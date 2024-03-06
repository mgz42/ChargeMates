class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Pour récupérer les véhicules et les stations de l'utilisateur actuel
    user_vehicles = current_user.vehicles
    user_stations = current_user.stations

    # Pour afficher seulement les bookings reliés aux véhicules et aux stations de l'utilisateur actuel
    @bookings = Booking.where(vehicle_id: user_vehicles.ids).or(Booking.where(station_id: user_stations.ids))  end
end
