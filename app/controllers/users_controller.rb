class UsersController < ApplicationController
  before_action :authorized, except: %i[login]
  before_action :authorizedAdmin, only: [:index, :destroy, :signup]
  before_action :set_user, only: %i[update destroy]

  # GET /users
  def index
    all_users = User.eager_load(:contact_information)

    users = all_users.map do |user|
      { user: { user: user.api_friendly,
               contact_information: user.contact_information.api_friendly,
               address: user.contact_information.address.api_friendly } }
    end

    render json: users
  end

  # GET /users/1
  def show
    render json: { user: { user: @user.api_friendly,
                          contact_information: @user.contact_information.api_friendly,
                          address: @user.contact_information.address.api_friendly } }
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /login
  def login
    # Find user
    user = User.find_by_email(user_params[:email])

    # Check if user is valid (Email matches in the database)
    unless user
      render json: { error: "Username and password don't match" }
      return
    end
    # Authenticate user
    if user.authenticate(user_params[:password])
      payload = { first_name: user.contact_information[:first_name], last_name: user.contact_information[:last_name], email: user[:email], user_id: user[:id], isAdmin: user[:isAdmin] }
      token = JWT.encode payload, "my$ecretK3y", "HS256"
      render json: { token: token }
      nil
    else
      render json: { error: "Username and password don't match" }
    end
  end

  # Check if Address already exists, if it does then return it
  def checkAddress
    address = Address.where(street_address: user_params[:street_address], street_number: user_params[:street_number],
                            suburb: user_params[:suburb], state: user_params[:state], postcode: user_params[:postcode]).first
    return address
  end

  # Check if ContactInformation already exists, if it does then return it
  def checkContactInformation
    contactInfo = ContactInformation.where(first_name: user_params[:first_name], last_name: user_params[:last_name],
                                           phone_number: user_params[:phone_number], email: params[:email]).first
    return contactInfo
  end

  # POST /signup
  def signup
    user = User.new(email: user_params[:email])
    user.isAdmin = false
    user.password = "Passw0rd!"
    # Create Address
    if !checkAddress
      address = Address.create(street_address: user_params[:street_address], street_number: user_params[:street_number],
                               suburb: user_params[:suburb], state: user_params[:state], postcode: user_params[:postcode])
    else
      address = checkAddress()
    end

    # Create contact Info
    if !checkContactInformation
      contactInfo = ContactInformation.new(first_name: user_params[:first_name], last_name: user_params[:last_name],
                                           phone_number: user_params[:phone_number], email: params[:email])
    else
      contactInfo = checkContactInformation()
    end

    contactInfo.address_id = address.id
    contactInfo.save

    # Add Contact Information to user
    user.contact_information_id = contactInfo.id

    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:email, :password, :first_name, :last_name, :phone_number, :street_number, :street_address,
                  :unit_number, :suburb, :state, :postcode)
  end
end
