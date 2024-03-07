class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
    user_vehicles = current_user.Vehicle.all
  end

  def new
    @user = current_user
    @vehicle = Vehicle.new
  end

  def create
    @user = current_user
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      @user.vehicles << @vehicle
      # redirect_to user_path(@user)
      # à décommenter après le merge
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Véhicule mis à jour avec succès.'
    else
      render :edit
    end
  end



  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :model_year, :immatriculation)
  end
end
