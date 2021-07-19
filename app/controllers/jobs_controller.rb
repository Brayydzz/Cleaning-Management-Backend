class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy, :job_check_in, :job_check_out, :job_assign_user]

  # GET /jobs
  def index
    all_jobs = Job.eager_load(:address)

    jobs = all_jobs.map do |job|
      job.serialize
    end

    render json: jobs
  end

  # GET /jobs/1
  def show
    render json: @job.serialize
  end

  # POST /jobs
  def create
    @job = Job.new(service_type_id: job_params[:service_type_id], due_date: job_params[:due_date], client_id: job_params[:client_id], reoccuring: job_params[:reoccuring], reoccuring_length: [:reoccuring_length])
    @job.address_id = checkAddress(job_params).id

    if @job.save
      render json: @job.serialize, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(service_type_id: job_params[:service_type_id], due_date: job_params[:due_date], client_id: job_params[:client_id], reoccuring: job_params[:reoccuring], reoccuring_length: [:reoccuring_length], address_id: checkAddress(job_params).id)
      render json: @job.serialize
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def job_check_in
    if @job.update_attribute(:time_in, job_params[:time_in])
      render json: @job.serialize
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def job_check_out
    if @job.update_attribute(:time_out, job_params[:time_out])
      render json: @job.serialize
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def job_assign_user
    if @job.update_attribute(:user_id, job_params[:user_id])
      render json: @job.serialize
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.permit(:id, :address_id, :service_type_id, :due_date, :client_id, :time_in, :time_out, :reoccuring, :reoccuring_length, :user_id, :street_number, :street_address,
                  :unit_number, :suburb, :state, :postcode)
  end
end