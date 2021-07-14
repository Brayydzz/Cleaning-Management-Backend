class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorized, except: [:login, :signup]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
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
    if (!user)
      render json: { error: "Username and password don't match" }
      return
    end
    # Authenticate user
    if (user.authenticate(user_params[:password]))
      payload = { name: user[:name], email: user[:email], user_id: user[:id] }
      token = JWT.encode payload, "my$ecretK3y", "HS256"
      render json: { token: token }
      return
    else
      render json: { error: "Username and password don't match" }
    end
  end

  # POST /signup
  def signup
    user = User.new(email: user_params[:email], password: user_params[:password])
    user.isAdmin = false
    # Create Address
    address = Address.create!(street_address: user_params[:street_address], street_number: user_params[:street_number], suburb: user_params[:suburb], state: user_params[:state], postcode: user_params[:postcode])

    #Create contact Info
    contactInfo = ContactInformation.new(first_name: user_params[:first_name], last_name: user_params[:last_name], phone_number: user_params[:phone_number])
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
    params.permit(:email, :password, :first_name, :last_name, :phone_number, :street_number, :street_address, :unit_number, :suburb, :state, :postcode)
  end
end
