class ContactInformationsController < ApplicationController
  before_action :set_contact_information, only: %i[show update destroy]

  # GET /contact_informations
  def index
    @contact_informations = ContactInformation.all

    render json: @contact_informations
  end

  # GET /contact_informations/1
  def show
    render json: @contact_information
  end

  # POST /contact_informations
  def create
    @contact_information = ContactInformation.new(contact_information_params)

    if @contact_information.save
      render json: @contact_information, status: :created, location: @contact_information
    else
      render json: @contact_information.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_informations/1
  def update
    if @contact_information.update(contact_information_params)
      render json: @contact_information
    else
      render json: @contact_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contact_informations/1
  def destroy
    @contact_information.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact_information
    @contact_information = ContactInformation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_information_params
    params.require(:contact_information).permit(:phone_number, :first_name, :last_name, :address_id)
  end
end
