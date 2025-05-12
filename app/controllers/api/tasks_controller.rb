class Api::TasksController < ApplicationController
  before_action :set_task, only: [:completed]

  def index
    tasks = Task.select(:id, :title, :description, :completed_at)

    render json: tasks, status: :ok
  end

  def create
    task = Task.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def completed
    if @task.update(completed_at: Time.current)
      render json: @task, status: :ok
    else
      render json: {errors: @task.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Task not found"}, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
