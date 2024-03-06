class BookingsController < ApplicationController


  def new
    @station = Station.find(params[:station_id])
    @booking = @station.bookings.new
  end

  def create
    @station = Station.find(params[:station_id])
    @booking = @station.bookings.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to bookings_path(@bookings)
    else
      render :new
    end
  end

  def show
    @booking = Booking.new
  end

  def edit; end

  def update
    @station.update(station_params)
    redirect_to station_path(@station)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:quantity)
  end
end
