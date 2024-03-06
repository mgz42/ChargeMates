class BookingsController < ApplicationController

  before_action :authenticate_user!

  def index
    # Pour récupérer les véhicules et les stations de l'utilisateur actuel
    user_vehicles = current_user.vehicles
    user_stations = current_user.stations

    # Pour afficher seulement les bookings reliés aux véhicules et aux stations de l'utilisateur actuel
    @bookings = Booking.where(vehicle_id: user_vehicles.ids).or(Booking.where(station_id: user_stations.ids))  
  end

  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def new
    @station = Station.find(params[:station_id])
    @booking = @station.bookings.new
  end

  def create
    @station = Station.find(params[:station_id])
    @booking = @station.bookings.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show
    @bookings = current_user.bookings
    @message = Message.new
  end

  def edit

  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to root_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:quantity)
  end

end
