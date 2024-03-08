class StationsController < ApplicationController
  def index
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
        # @stations = Station.all // for testing purposes only
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

    @booking = Booking.new
  end


  def new
    @station = Station.new
  end


  def create
    @station = Station.new(station_params)
    @station.user = @user

    respond_to do |format|
      if @station.save
        format.html { redirect_to user_path(@user), notice: "Flat was successfully created." }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end
    #if @station.save

    #  redirect_to user_path(@user), notice: "Nous avons ajouté votre station de recharge."
    #else
    #  raise
    #  flash.now[:error] = "Nous n'avons pas pu ajouter votre station de recharge."
    #  render :new
    #end
  #end

  private

  def station_params
    params.require(:station).permit(:address, :plug, :brand, :model, :max_kW_recharge, :available, :availability_end, :code_station, :latitude, :longitude)
  end

end
