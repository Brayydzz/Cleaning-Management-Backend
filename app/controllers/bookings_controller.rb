class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update destroy]
  before_action :authorizedAdmin, except: [:create]

  # GET /bookings
  def index
    @bookings = Booking.all

    render json: @bookings, status: :ok
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render json: @booking, status: :created, location: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
    render json: { message: "Deleted booking!" }, status: 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :email, :body, :phone_number, :service_type_id)
  end
end
