class ServiceTypesController < ApplicationController
  before_action :set_service_type, only: %i[show update destroy]

  # GET /service_types
  def index
    @service_types = ServiceType.all

    render json: @service_types, status: :ok
  end
end
