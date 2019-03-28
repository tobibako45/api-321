class TodosController < ApplicationController


  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.IiM8VXNlcjoweDAwMDA3ZmRlY2QyZTlmNjA-Ig.X8wPJjfHbtmAL2Rzhb6oxJJZv3eKunfOTlkUYCD25_c' --header 'Content-Type: application/json'

  #
  # curl -F title=たすく -F description=テスト説明 http://localhost:3000/todos -H 'Authorization: Token eyJhbGciOiJIUzI1NiJ9eyJlbWFpbCI6ImZhdHpzam9uQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiZmF0empvbjEyMiJ9.Ei1Ojd6dbSOJmJAqmOOmH3TBEFDKnNKVpdsxmB2l9rc'
  #
  #
  # curl --request GET --url http://localhost:3000/api/v1/todos --header 'Content-Type: application/json' --header 'Authorization: eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxNH0.TuayXkaFQi7hBSYdwY8373G7MGRZSLHz3zo2acMagssqhYbYvhX1JN3rCUbZO1v9EK1tI_E6xouz18LTJupJ5653I0rsGfNJl9vndw_VUXVDMNj2sHR113M3KJX46MMpmt-jLWh370XjZIwLz-PBOizGV2wX4_ccSnRTbOw' | jq
  #
  #
  # curl -X POST --url http://localhost:3000/todos --header 'Content-Type: application/json'  --header 'eyJhbGciOiJIUzI1NiJ9.IiM8VXNlcjoweDAwMDA3ZjhlZDUxMTM4NTA-Ig.382xwvXcdcOugKVT4RQ9jh72H6XKhE9hEQFia0KIEV8' -d '{"title": "title", "description": "test1description}'


  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    @todo = Todo.find(params[:id])
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

  private

  def todo_params
    params.fetch(:todo, {}).permit(:title, :description, :status, :user_id)
  end

end
