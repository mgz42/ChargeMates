class StationsController < ApplicationController
  def index
    @vehicles = current_user.vehicles

    @array_of_cars = []
    @vehicles.each do |vehicle|
      arr = []
      arr.push(" " + vehicle.brand + " " + vehicle.model + " - " + vehicle.plug + " ")
      arr.push(vehicle.plug)
      @array_of_cars.push(arr)
    end

      if params[:address] && params[:plug] && params[:date_available]
        # @stations = Station.near(params[:address], 10, order: :distance).where('plug = ? AND available = ? AND ( avaibility_end IS NULL OR avaibility_end < ? )', params[:plug], 'true', params[:date_available].to_time)
        @stations = Station.all
      else
        @stations = ""
      end

    # wip ci dessous
    if @stations != ""
      @markers = @stations.geocoded.map do |station|
        {
          lat: station.latitude,
          lng: station.longitude
        }
      end
      location = Geocoder.search(params[:address])[0]
      @markers.push({lat: location.latitude, lng: location.longitude}) if location
    else
      @markers = [];
    end
  end
end
