class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    # Pour récupérer les véhicules et la station de l'utilisateur actuel
    user_vehicles = current_user.vehicles
    user_station = current_user.station
    user_vehicles_ids = Vehicle.where(user_id: params[:user_id]).pluck(:id)

    # Pour afficher seulement les bookings reliés aux véhicules et aux stations de l'utilisateur actuel
    if current_user.station
      @bookings = Booking.where(vehicle_id: user_vehicles.ids).or(Booking.where(station_id: user_station.id)).order('created_at DESC')
    else
      @bookings = Booking.where(vehicle_id: user_vehicles.ids).order('created_at DESC')
    end
  end

  def new
    @station = Station.find(params[:station_id])
    @booking = @station.bookings.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.station_id = params[:station_id]
    @booking.status = "en attente"
    orders_update = current_user.orders ? current_user.orders + 1 : 1
    current_user.update(orders: orders_update)
    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def show
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
    redirect_to user_path(current_user)
  end

  private

  def update_duration
    booking = Booking.find(params[:id])
    booking.update(duree_recharge: params[:duree_recharge].to_f)
    render json: { success: true }
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date_heure_reservation, :vehicle_id)
  end
end
