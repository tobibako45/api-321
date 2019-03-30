class TodosController < ApplicationController
  before_action :authenticated_user

  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.IiM8VXNlcjoweDAwMDA3ZmRlY2QyZTlmNjA-Ig.X8wPJjfHbtmAL2Rzhb6oxJJZv3eKunfOTlkUYCD25_c' --header 'Content-Type: application/json'

  #
  # curl -F title=たすく -F description=テスト説明 http://localhost:3000/todos -H 'Authorization: Token eyJhbGciOiJIUzI1NiJ9eyJlbWFpbCI6ImZhdHpzam9uQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiZmF0empvbjEyMiJ9.Ei1Ojd6dbSOJmJAqmOOmH3TBEFDKnNKVpdsxmB2l9rc'
  #
  #
  # curl --request GET --url http://localhost:3000/api/v1/todos --header 'Content-Type: application/json' --header 'Authorization: eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxNH0.TuayXkaFQi7hBSYdwY8373G7MGRZSLHz3zo2acMagssqhYbYvhX1JN3rCUbZO1v9EK1tI_E6xouz18LTJupJ5653I0rsGfNJl9vndw_VUXVDMNj2sHR113M3KJX46MMpmt-jLWh370XjZIwLz-PBOizGV2wX4_ccSnRTbOw' | jq
  #
  #
  # curl -X POST --url http://localhost:3000/todos --header 'Content-Type: application/json'  --header 'eyJhbGciOiJIUzI1NiJ9.IiM8VXNlcjoweDAwMDA3ZjhlZDUxMTM4NTA-Ig.382xwvXcdcOugKVT4RQ9jh72H6XKhE9hEQFia0KIEV8' -d '{"title": "title", "description": "test1description}'
  #

  # 自分のタスク一覧API
  #   curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'

  #   curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIyQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.Sr91OwGTeyQfRPYE1jXrvK6Luon0XZc8KjzxcYA35fQ' --header 'Content-Type: application/json'


  # 詳細
  # curl -X GET --url http://localhost:3000/todos/2 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'

  # curl -X GET --url http://localhost:3000/todos/11 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIyQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.Sr91OwGTeyQfRPYE1jXrvK6Luon0XZc8KjzxcYA35fQ' --header 'Content-Type: application/json' | jq

  # create
  #   curl -F title=たすく -F description=テスト説明 http://localhost:3000/todos -H 'Authorization: Token eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U'

  def index
    @todos = @authenticated_user.todos.all
    render json: @todos
  end

  def show
    if @authenticated_user.todos.exists?(id: params[:id])
      @todo = @authenticated_user.todos.find(params[:id])
      render json: @todo
    else
      render json: {"status": 403, "message": "権限がありません"}
    end
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: {status: 200, message: 'タスクを作成しました'}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

  private

  def todo_params
    raw_parameters = {title: params[:title], description: params[:description], user_id: @authenticated_user.id}
    parameters = ActionController::Parameters.new(raw_parameters)
    parameters.permit(:title, :description, :user_id)
  end

end
