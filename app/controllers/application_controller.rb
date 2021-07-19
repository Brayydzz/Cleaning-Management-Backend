class ApplicationController < ActionController::API
  def decoded_token
    token = request.authorization.split[1]
    if token
      begin
        JWT.decode(token, "my$ecretK3y", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def is_admin?
    if logged_in?
      @user.isAdmin
    else
      false
    end
  end

  def authorizedAdmin
    render json: { error: "You must have admin role to do this!" }, status: :unauthorized unless is_admin?
  end

  def authorized
    render json: { error: "You must be logged in to do this!" }, status: :unauthorized unless logged_in?
  end

  # Check if Address already exists, if it does then return it
  def checkAddress(params)
    address = Address.where(street_address: params[:street_address], street_number: params[:street_number],
                            suburb: params[:suburb], state: params[:state], postcode: params[:postcode]).first
    address ||= Address.create(street_address: params[:street_address], street_number: params[:street_number],
                               suburb: params[:suburb], state: params[:state], postcode: params[:postcode])
    address
  end

  # Check if ContactInformation already exists, if it does then return it
  def checkContactInformation(params)
    contactInfo = ContactInformation.where(first_name: params[:first_name], last_name: params[:last_name],
                                           phone_number: params[:phone_number], email: params[:email]).first

    contactInfo ||= ContactInformation.new(first_name: params[:first_name], last_name: params[:last_name],
                                           phone_number: params[:phone_number], email: params[:email])
    contactInfo.address_id = checkAddress(params).id
    contactInfo.save
    contactInfo
  end
end
