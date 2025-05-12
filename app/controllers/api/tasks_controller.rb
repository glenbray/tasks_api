class Api::TasksController < ApplicationController
  def index
    render json: [], status: :ok
  end
end
