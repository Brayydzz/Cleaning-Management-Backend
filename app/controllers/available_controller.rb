class AvailableController < ApplicationController
  @@freedom_string = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  before_action :set_available, only: %i[update destroy]

  # POST /users/:userid/available
  def create
    if !available_params[:freedom]
      created = User.find(params[:id]).availables.create(day: available_params[:day], freedom: @@freedom_string)
    else
      created = User.find(params[:id]).availables.create(available_params)
    end
    # Delete out of date records
    Available.where("day <= ?", Time.now - 1.day).destroy_all
    render json: created
  end

  # GET /users/:userid/available
  def show
    availables = User.find(params[:id]).availables
    render json: availables
  end

  # PATCH/PUT /available/:id
  def update
    if @available.update_attribute(:freedom, available_params[:freedom])
      render json: @user.serialize
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /available/:id
  def destroy
    @available.destroy
  end

  private

  def available_params
    params.permit(:day, :freedom)
  end

  def set_available
    @available = Available.find(params[:id])
  end
end
