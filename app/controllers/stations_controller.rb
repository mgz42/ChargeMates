class StationsController < ApplicationController
  before_action do
    current_user.badges.each do |badge|
      if badge.duration < Time.now
        badge.destroy
      end
    end
  end


  def index

    redirect_to new_vehicle_path if current_user.vehicles.length < 1

    @vehicles = current_user.vehicles

    @array_of_cars = []
    @vehicles.each do |vehicle|
      arr = []
      arr.push(" " + vehicle.brand + " " + vehicle.model + " - " + vehicle.plug + " ")
      arr.push(vehicle.id)
      @array_of_cars.push(arr)
    end

      if params[:address] && params[:plug] && params[:date_available]
        @stations = Station.near(params[:address], 10, order: :distance).where('user_id <> ? AND plug = ? AND available = ? AND ( avaibility_end IS NULL OR avaibility_end < ? )',current_user.id, Vehicle.find(params[:plug]).plug, 'true', params[:date_available].to_time)
        # @stations = Station.all
      else
        @stations = ""
      end
    # wip ci dessous
    if @stations != ""
      @markers = @stations.geocoded.map do |station|
        {
          lat: station.latitude,
          lng: station.longitude,
          niv: station.user.xp,
          marker_html: render_to_string(partial: "marker"),
          marker_html_2: render_to_string(partial: "marker_2"),
          marker_html_3: render_to_string(partial: "marker_3"),
          marker_html_4: render_to_string(partial: "marker_4"),
          info_window_html: render_to_string(partial: "info_window", locals: {station: station})
        }
      end
      location = Geocoder.search(params[:address])[0]
      @markers.push({lat: location.latitude, lng: location.longitude, bs: "true", marker_html_5: render_to_string(partial: "marker_5") }) if location
    else
      @markers = [];
    end

    @booking = Booking.new
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    @station.user = current_user

    if @station.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Station.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private

  def station_params
    params.require(:station).permit(:address, :plug, :brand, :model, :max_kW_recharge, :available, :availability_end, :code_station, :latitude, :longitude, :photo)
  end

  

end
