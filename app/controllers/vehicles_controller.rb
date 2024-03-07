class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create]

  def index
    user_vehicles = current_user.Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
    @car_list = Vehicle.car_list
    @all_car_models = @car_list.values.flat_map { |car| car['Modeles'] }.uniq
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user = @user
    if @vehicle.save
      redirect_to user_path(current_user), notice: 'Vehicle was successfully created.'
    else
      flash.now[:error] = 'Failed to create vehicle. Please check the form.'
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :model_year, :immatriculation)
  end
end
