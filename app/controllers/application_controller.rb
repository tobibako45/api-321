class ApplicationController < ActionController::API

  private

  def authenticate
    if request.headers["Authorization"].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        # decode
        JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      rescue JWT::VerificationError, JWT::DecodeError => e
        render json: {status: 400, message: "認証に失敗しました"}
      end
    else
      render json: {status: 401, message: "ログインしてください"}
    end
  end

  def authenticated_user
    User.find_by(email: authenticate["email"])
  end

end
