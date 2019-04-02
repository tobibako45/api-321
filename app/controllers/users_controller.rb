class UsersController < ApplicationController

  def index
    users = User.pluck(:name)
    username_list = []
    users.each {|user| username_list << {name: user}}
    render json: username_list
  end

  def show
    user = User.where(id: params[:id]).pluck(:name, :description)
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 200, message: 'ユーザー登録が完了しました'}
    else
      render json: {status: 400, message: user.errors.full_messages}
    end
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user
      user_data = {email: user.email, password: user.password}
      # encode
      render json: {access_token: JWT.encode(user_data, Rails.application.credentials.secret_key_base, "HS256")}
    else
      render json: {status: 401, message: "認証に失敗しました"}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :description, :email, :password)
  end

end


