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

  def isAdmin?
    @user.isAdmin
  end

  def authorized
    render json: { error: "You must be logged in to do this!" }, status: :unauthorized unless logged_in?
  end
end
