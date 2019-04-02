class TodosController < ApplicationController
  before_action :authenticated_user
  before_action :user_todos, only: [:show, :update, :destroy]

  def index
    todos = authenticated_user.todos.inject([]) {|arr, val|
      arr.push("title": val.title, "status": val.status)
    }
    render json: todos
  end

  def show
    todo = authenticated_user.todos.where(id: params[:id]).inject([]) {|arr, val|
      arr.push("title": val.title, "description": val.description, "status": val.status)
    }
    render json: todo
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: {status: 200, message: 'タスクを作成しました'}
    else
      render json: {status: 400, message: todo.errors.full_messages}
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.update(title: todo_params[:title], description: todo_params[:description], status: status_params[:status], user_id: todo_params[:user_id])
      render json: {"status": 200, "message": "タスクを更新しました"}
    else
      render json: {status: 400, message: todo.errors.full_messages}
    end
  end

  def destroy
    Todo.find(params[:id]).destroy
    render json: {"status": 200, "message": "タスクを削除しました"}
  end

  private

  def user_todos
    unless authenticated_user.todos.exists?(id: params[:id])
      render json: {"status": 403, "message": "権限がありません"}
    end
  end

  def todo_params
    raw_parameters = {
        title: params[:title],
        description: params[:description],
        user_id: authenticated_user.id
    }
    parameters = ActionController::Parameters.new(raw_parameters)
    parameters.permit(:title, :description, :user_id)
  end

  def status_params
    params.require(:todo).permit(:status)
  end

end