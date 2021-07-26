class UsersController < ApplicationController
  before_action :authorized, except: %i[login]
  before_action :authorizedAdmin, only: [:destroy, :signup]
  before_action :set_user, only: %i[update destroy]

  # GET /users
  def index
    all_users = User.eager_load(:contact_information)

    users = all_users.map do |user|
      user.serialize
    end

    render json: users, status: :ok
  end

  # GET /users/1
  def show
    render json: @user.serialize, status: :ok
  end

  # PATCH/PUT /users/1
  def update
    if (@user.id == logged_in_user.id)
      if (user_params[:password])
        if @user.update(password: user_params[:password], contact_information_id: checkContactInformation(user_params).id)
          render json: @user.serialize, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        if @user.update_attribute(:contact_information_id, checkContactInformation(user_params).id)
          render json: @user.serialize, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    else
      render json: { error: "You are not the owner of this account!" }, status: :unauthorized
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { message: "Employee Delete" }, status: 204
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
      render json: { token: token }, status: :ok
      nil
    else
      render json: { error: "Username and password don't match" }, status: :unauthorized
    end
  end

  # POST /signup

  def signup
    user = User.new(email: user_params[:email])
    user.isAdmin = false
    user.password = "Passw0rd!"
    user.contact_information_id = checkContactInformation(user_params).id

    if user.save
      render json: user.serialize, status: :created, location: user.serialize
    else
      render json: { error: user.errors }, status: :unprocessable_entity
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
