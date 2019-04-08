class UsersController < ApplicationController

  def index
    users = User.all.inject([]) {|arr, val|
      arr.push("name": val.name)
    }
    render json: users
  end

  def show
    p user = User.where(id: params[:id]).inject([]) {|arr, val|
      arr.push("name": val.name, "description": val.description)
    }
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 200, message: 'ユーザー登録が完了しました'}, status: 200
    else
      render json: {status: 400, message: user.errors.full_messages}, status: 400
    end
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user
      encode_token(user)
    else
      render json: {status: 401, message: "認証に失敗しました"}, status: 401
    end
  end

  def refresh
    refresh_token = params[:refresh_token]
    begin
      # decode
      user_email = JWT.decode(refresh_token, Rails.application.credentials.secret_key_base)[0]
    rescue JWT::ExpiredSignature => e
      render json: {status: 401, message: "有効期限が切れました"}, status: 401
    rescue JWT::VerificationError, JWT::DecodeError => e
      render json: {status: 400, message: "認証に失敗しました"}, status: 400
    end
    user = User.find_by(email: user_email)
    encode_token(user)
  end


  private

  def encode_token(user)
    user_data = {email: user.email, password: user.password}
    # １分後を期限
    exp = Time.now.since(1.minute).to_i
    user_data[:exp] = exp
    # encode
    render json: {access_token: JWT.encode(user_data, Rails.application.credentials.secret_key_base, "HS256"),
                  refresh_token: JWT.encode(user.email, Rails.application.credentials.secret_key_base, "HS256")}
  end

  def user_params
    params.require(:user).permit(:name, :description, :email, :password)
  end

end