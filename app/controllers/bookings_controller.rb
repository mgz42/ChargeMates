class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy]
#   before_action :set_booking, only: [:show, :update, :destroy, :submit_offer, :accept_offer, :reject_offer, :start_charge, :stop_charge, :validate_payment]
  before_action do
    current_user.badges.each do |badge|
      if badge.duration < Time.now
        badge.destroy
      end
    end
  end

  def index
    # Pour récupérer les véhicules et la station de l'utilisateur actuel
    user_vehicles = current_user.vehicles
    user_station = current_user.station
    user_vehicles_ids = Vehicle.where(user_id: params[:user_id]).pluck(:id)
    station_bookings = current_user.station.bookings.where.not(status: 'en_attente_de_soumission') if current_user.station.present?
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

    @booking.status = 'en_attente_de_soumission'

    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def show
    @message = Message.new
    @is_owner = (current_user == @booking.vehicle.user)
  end

  def update
    @is_owner = (current_user == @booking.vehicle.user)
    check_and_return(@booking)
    case @booking.status
      when "en_attente_de_confirmation" then submit_offer
      when "en_attente_de_validation" then accept_offer
      when "en_attente_de_paiement" then validate_payment
      when "en_attente_de_charge" then start_charge
      when "en_charge" then stop_charge
    end
    ActionBookingChannel.broadcast_to(
      @booking,
      render_to_string(partial: "bookings/action_choice", locals: { booking: @booking, is_owner: @is_owner } ),
    )
  end

  def destroy
    @booking.destroy
    redirect_to user_path(current_user)
  end

  private

  def check_and_return(booking)
    if booking.status == "en_attente_de_soumission"
      booking.update(booking_params)
      booking.initier_offre!
      redirect_to booking_path(booking), notice: 'Réservation mise à jour avec succès.'
      return
    end
  end

  def submit_offer
    @booking.soumettre_offre!
  end

  def accept_offer
    @booking.accepter_offre!
  end

  def reject_offer
    @booking.refuser_offre!
  end

  def start_charge
    @booking.commencer_charge!
  end

  def stop_charge
    @booking.terminer_charge!
  end

  def validate_payment
    @booking = Booking.find(params[:id])
  @booking.valider_paiement!
  rescue ActiveRecord::RecordNotFound
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:vehicle_id, :station_id, :date_heure_reservation, :date_heure_fin_de_reservation)
  end
end
