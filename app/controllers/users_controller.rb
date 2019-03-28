class UsersController < ApplicationController
  # before_action :authenticate, except: [:login]


  # 登録
  # curl --request POST --url http://localhost:3000/users --header 'Content-Type: application/json' --data '{"name": "test2","description": "des3", "email": "","password": ""}'

  # curl -X POST --url http://localhost:3000/users --header 'Content-Type: application/json' -d '{"name": "test6", "email": "test7@test.com","password": "password"}'

  # ログイン
  # curl --request POST --url http://localhost:3000/users/login --header 'Content-Type: application/json' --data '{"email":"test1@test.com","password": "password"}'

# 一覧
  # curl --request GET --url http://localhost:3000/users --header 'Content-Type: application/json'

  # 詳細
  # curl -X GET --url http://localhost:3000/users/1 --header 'Content-Type: application/json'


  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNvY29va2luZ0BsaXZlLmpwIiwicGFzc3dvcmQiOiJjb2Nvb2tpbmcifQ.X5TV5RG_SlFSUl_8-QU3n5PixmVpex2Nsp1ziWryeXc' --header 'Content-Type: application/json'


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

    # if params[:email].brank?
    #   render json: {"status": 400, "message": "メールアドレスを入力してください"}
    # end
    #
    # if params[:password].brank?
    #   render json: {"status": 400, "message": "パスワードを入力してください"}
    # end

    user = User.find_by(email: params[:email], password: params[:password])

    if user
      # 秘密鍵生成
      # rsa_private = OpenSSL::PKey::RSA.generate(2048)
      # render json: {access_token: JWT.encode(user, rsa_private, 'RS256')}

      # render json: {access_token: JWT.encode(user, Rails.application.secrets.secret_key_base, "HS256")}

      # userをエンコード
      render json: {access_token: JWT.encode(user, Rails.application.credentials.secret_key_base)}
    else
      render json: {status: 401, message: "認証に失敗しました"}
      # render json: {status: 400, message: user.errors.full_messages}
    end
  end


  private

  def authenticate
    # requestに、headers["Authorization"]がある時
    if request.headers["Authorization"].present?
      token = request.headers['Authorization'].split(' ').last
      # デコード
      # @user = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: "HS256" })[0]
      @user = JWT.decode(token, Rails.application.credentials.secret_key_base)
      # @user = decode(token)
    else
      render json: {status: 401, message: "ログインしてください"}
    end
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :description, :email, :password)
  end

end


