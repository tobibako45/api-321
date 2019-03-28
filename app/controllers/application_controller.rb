class ApplicationController < ActionController::API

  private

  def authenticate
    if request.headers["Authorization"].present?
      token = request.headers['Authorization'].split(' ').last
      # decode
      p @user = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: "HS256" })[0]
      p @user["email"]
      p @user["password"]
    else
      render json: {status: 401, message: "ログインしてください"}
    end
  end

end
