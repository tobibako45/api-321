class TodosController < ApplicationController
  before_action :authenticated_user
  before_action :user_todos, only: [:show, :update, :destroy]

  # 自分のタスク一覧API
  #   curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'

  #   curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIyQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.Sr91OwGTeyQfRPYE1jXrvK6Luon0XZc8KjzxcYA35fQ' --header 'Content-Type: application/json'


  # 詳細
  # curl -X GET --url http://localhost:3000/todos/2 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'

  # curl -X GET --url http://localhost:3000/todos/11 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIyQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.Sr91OwGTeyQfRPYE1jXrvK6Luon0XZc8KjzxcYA35fQ' --header 'Content-Type: application/json' | jq

  # create
  #   curl -F title=たすく -F description=テスト説明 http://localhost:3000/todos -H 'Authorization: Token eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U'

  # update
  # curl -X PATCH --url http://localhost:3000/todos/1 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'  --data '{"title":"タイトル変えたよ","description": "description変えたよ", "status": 1}'

  # delete
  # curl -X DELETE --url http://localhost:3000/todos/1 --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IlVzZXIxQHRlc3QuY29tIiwicGFzc3dvcmQiOiJwYXNzd29yZCJ9.ktm6lvVnqQGhFNdNCWWFeTbKHvRCFy_UlfhIal-E06U' --header 'Content-Type: application/json'

  def index
    @todos = @authenticated_user.todos.all
    render json: @todos
  end

  def show
    @todo = @authenticated_user.todos.find(params[:id])
    render json: @todo
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: {status: 200, message: 'タスクを作成しました'}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      render json: {"status": 200, "message": "タスクを更新しました"}
    else
      render json: {status: 400, message: @todo.errors.full_messages}
    end
  end

  def destroy
    Todo.find(params[:id]).destroy
    render json: {"status": 200, "message": "タスクを削除しました"}
  end

  private

  def user_todos
    unless @authenticated_user.todos.exists?(id: params[:id])
      render json: {"status": 403, "message": "権限がありません"}
    end
  end

  def todo_params
    raw_parameters = {
        title: params[:title],
        description: params[:description],
        status: params[:status],
        user_id: @authenticated_user.id
    }
    parameters = ActionController::Parameters.new(raw_parameters)
    parameters.permit(:title, :description, :status, :user_id)
  end

end
