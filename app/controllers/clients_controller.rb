class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]
  before_action :authorized
  before_action :authorizedAdmin, only: [:create, :destroy, :update]

  # GET /clients
  def index
    all_clients = Client.eager_load(:contact_information)

    clients = all_clients.map do |client|
      { client_data: {
        client: client,
        contact_information: client.contact_information.api_friendly,
        address: client.contact_information.address.api_friendly,
      } }
    end
    render json: clients
  end

  # GET /clients/1
  def show
    client = { client_data: {
      client: @client,
      contact_information: @client.contact_information.api_friendly,
      address: @client.contact_information.address.api_friendly,
    } }
    render json: client
  end

  # POST /clients
  def create
    client = Client.new()
    client.contact_information_id = checkContactInformation(client_params).id

    if client.save
      response = { client_data: {
        client: client,
        contact_information: client.contact_information.api_friendly,
        address: client.contact_information.address.api_friendly,
      } }
      render json: response, status: :created, location: response
    else
      render json: client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(contact_information_id: checkContactInformation(client_params).id)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.permit(:email, :first_name, :last_name, :phone_number, :street_number, :street_address,
                  :unit_number, :suburb, :state, :postcode)
  end
end
