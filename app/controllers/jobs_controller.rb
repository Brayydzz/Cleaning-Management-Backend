class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy, :job_check_in, :job_check_out, :job_assign_user, :create_notes, :job_upload_images, :destroy_note]
  before_action :authorized
  before_action :authorizedAdmin, only: [:create, :destroy, :update]

  # GET /jobs
  def index
    all_jobs = Job.eager_load(:address).order(due_date: :desc)

    jobs = all_jobs.map do |job|
      job.serialize
    end

    render json: jobs, status: :ok
  end

  # GET /jobs/1
  def show
    render json: @job.serialize, status: :ok
  end

  # POST /jobs
  def create
    @job = Job.new(service_type_id: job_params[:service_type_id], due_date: job_params[:due_date], client_id: job_params[:client_id], reoccuring: job_params[:reoccuring], reoccuring_length: job_params[:reoccuring_length], user_id: job_params[:user_id], address_id: job_params[:address_id])
    # @job.address_id = checkAddress(job_params).id

    if @job.save
      render json: @job.serialize, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(service_type_id: job_params[:service_type_id], due_date: job_params[:due_date], client_id: job_params[:client_id], reoccuring: job_params[:reoccuring], reoccuring_length: [:reoccuring_length], address_id: checkAddress(job_params).id)
      render json: @job.serialize, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  #POST /jobs/:id/checkin
  def job_check_in
    if @job.update_attribute(:time_in, job_params[:time_in])
      render json: @job.serialize, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # POST /jobs/:id/checkout
  def job_check_out
    # Create new Job based on old job is recurring
    if @job.reoccuring
      @clone = @job.dup
      # puts @clone.due_date, "*******************************"
      # puts DateTime.strptime((@clone.due_date.to_f + (@clone.reoccuring_length.to_f * 24 * 60 * 60 * 1000)).to_s, "%s").to_time.to_f, "*******************************"
      # puts @clone.reoccuring_length, "*******************************"
      # puts (@clone.reoccuring_length.to_f * 86400).to_s, "*******************************"
      # puts @clone.reoccuring_length, "*******************************"

      @clone.time_in = nil
      @clone.due_date = DateTime.strptime((@clone.due_date.to_f + (@clone.reoccuring_length.to_f * 24 * 60 * 60 * 1000)).to_s, "%s").to_time.to_f
      @clone.save!
    end

    if @job.update_attribute(:time_out, job_params[:time_out])
      render json: @job.serialize, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # POST /jobs/:id/images
  def job_upload_images
    params[:pictures].each do |k, v|
      image = Cloudinary::Uploader.upload(params[:pictures][k])
      item = @job.pictures.create!(url: image["url"], public_id: image["public_id"])
    end
    render json: @job.serialize, status: :created
  end

  # POST /jobs/:id/notes
  def create_notes
    if @job.notes.create(note: job_params[:note])
      render json: @job.serialize, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/:id/notes/:nid
  def destroy_note
    @job.notes.find(params[:nid]).destroy
    render json: @job.serialize, status: :ok
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    render json: { message: "Job destroyed" }, status: 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.permit(:id, :address_id, :service_type_id, :due_date, :client_id, :time_in, :time_out, :reoccuring, :reoccuring_length, :user_id, :street_number, :street_address,
                  :unit_number, :suburb, :state, :postcode, :note, :pictures)
  end
end
