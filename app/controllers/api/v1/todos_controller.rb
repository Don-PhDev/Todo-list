class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all
    limit = params[:_limit]

    if limit.present?
      limit = limit.to_i
      @todos = @todos.last(limit)
    end

    render json: @todos.reverse
  end

  def show
    render json: @todo
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      success
    else
      failure
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:id, :title, :is_completed, :_limit)
  end
end
