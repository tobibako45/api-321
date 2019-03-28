class UsersController < ApplicationController

  # 登録
  # curl --request POST --url http://localhost:3000/users --header 'Content-Type: application/json' --data '{"name": "test2","description": "des3", "email": "","password": ""}'

  # curl -X POST --url http://localhost:3000/users --header 'Content-Type: application/json' -d '{"name": "test6", "email": "test7@test.com","password": "password"}'

  # ログイン
  # curl --request POST --url http://localhost:3000/users/login --header 'Content-Type: application/json' --data '{"email":"User1@test.com","password": "password"}'

# 一覧
  # curl --request GET --url http://localhost:3000/users --header 'Content-Type: application/json'

  # 詳細
  # curl -X GET --url http://localhost:3000/users/1 --header 'Content-Type: application/json'


  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'


  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIyQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.Sr91OwGTeyQfRPYE1jXrvK6Luon0XZc8KjzxcYA35fQ' --header 'Content-Type: application/json'


  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: 200, message: 'ユーザー登録が完了しました'}
    else
      render json: {status: 400, message: @user.errors.full_messages}
    end
  end


  def login

    user = User.find_by(email: params[:email], password: params[:password])

    if user
      user_data = { email: user.email, password: user.password }
      # encode
      render json: {access_token: JWT.encode(user_data, Rails.application.credentials.secret_key_base, "HS256")}
    else
      render json: {status: 401, message: "認証に失敗しました"}
      # render json: {status: 400, message: user.errors.full_messages}
    end
  end


  private

  def user_params
    params.fetch(:user, {}).permit(:name, :description, :email, :password)
  end

end


