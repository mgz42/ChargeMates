class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create]
  before_action :set_vehicle, only: [:edit, :update, :destroy]

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

  def edit
<<<<<<< Updated upstream
  @vehicle = Vehicle.find(params[:id])
=======
    @user = current_user
    #@vehicle = Vehicle.find(params[:id])
    @vehicle_list = Vehicle.car_list # Si vous avez une méthode car_list qui renvoie une liste de marques de véhicules
    @all_vehicle_models = @vehicle_list.values.flat_map { |car| car['Modeles'] }.uniq
>>>>>>> Stashed changes
  end

  def update
    #@vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Véhicule mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to user_path(@user), notice: "Véhicule supprimé avec succès."
  end

  private

  def set_user
    @user = current_user
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :model_year, :immatriculation)
  end
end
