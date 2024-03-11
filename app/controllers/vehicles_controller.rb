class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create]
  before_action :populate_all_car_models, only: [:create]
  before_action :set_vehicle, only: [:edit, :update, :destroy]

  def index
    user_vehicles = current_user.Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
    @car_list = Vehicle.car_list
    @all_car_models = @car_list.values.flat_map { |car| car['Modeles'] }.uniq
  end

  def get_models_by_brand
    selected_brand = params[:brand]
    models_for_selected_brand = @all_vehicle_models[selected_brand]['Modeles']
    render json: models_for_selected_brand
  end

  def create

    selected_brand = params[:vehicle][:brand]
    selected_model = params[:vehicle][:model]

    car_details = Vehicle.car_list[selected_brand]

    if car_details && car_details['Modeles'].include?(selected_model)
      @vehicle = Vehicle.new(vehicle_params)
      @vehicle.user = @user

      @vehicle.attributes = {
        brand: selected_brand,
        model: selected_model,
        plug: car_details['Type_prise'],
        max_kW_recharge: car_details['Puissance_maximale_recharge'],
        # Add other attributes as needed
      }

      if @vehicle.save
        redirect_to user_path(current_user)
      else
        flash.now[:error] = 'Failed to create vehicle. Please check the form.'
        render :new
      end
    end
  end

  def edit
    @user = current_user
    # @vehicle = Vehicle.find(params[:id])
    @vehicle_list = Vehicle.car_list # Si vous avez une méthode car_list qui renvoie une liste de marques de véhicules
    @all_vehicle_models = @vehicle_list.values.flat_map { |car| car['Modeles'] }.uniq
  end

  def update
    # @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      @user = current_user # Assurez-vous que current_user est défini correctement
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to user_path(current_user)
  end

  private

  def populate_all_car_models
    @all_vehicle_models = Vehicle.all_car_models
  end

  def set_user
    @user = current_user
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :model_year, :immatriculation, :plug, :max_kW_recharge)
  end
end
