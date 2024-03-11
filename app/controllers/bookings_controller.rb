class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy, :submit_offer, :accept_offer, :reject_offer, :start_charge, :stop_charge, :validate_payment]


  def index
    # Récupération des réservations liées aux véhicules de l'utilisateur.
    vehicle_bookings = Booking.where(vehicle_id: current_user.vehicles.ids)

    # Si l'utilisateur possède une station, récupère aussi les réservations liées à cette station,
    # mais exclut les réservations "en attente de soumission" faites par d'autres utilisateurs.
    station_bookings = current_user.station.bookings.where.not(status: 'en_attente_de_soumission') if current_user.station.present?

    # Combine les réservations de véhicules et de station tout en s'assurant de ne pas dupliquer
    # les réservations en attente de soumission pour les véhicules de l'utilisateur.
    @bookings = vehicle_bookings.or(station_bookings).distinct.order(created_at: :desc) if station_bookings.present?
    @bookings ||= vehicle_bookings.order(created_at: :desc) # S'il n'y a pas de station, utilise uniquement les réservations de véhicules.
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
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: 'Réservation mise à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: 'Réservation supprimée avec succès.'
  end

  # Actions spécifiques liées au workflow de la réservation

  def submit_offer
    @booking = Booking.find(params[:id])
    @booking.soumettre_offre!
    redirect_to booking_path(@booking)
  end

  def accept_offer
    @booking.accepter_offre!
    redirect_to booking_path(@booking), notice: 'Offre acceptée.'
  end

  def reject_offer
    @booking.refuser_offre!
    redirect_to booking_path(@booking), notice: 'Offre rejetée.'
  end

  def start_charge
    @booking.commencer_charge!
    redirect_to booking_path(@booking), notice: 'Charge démarrée.'
  end

  def stop_charge
    @booking.terminer_charge!
    redirect_to booking_path(@booking), notice: 'Charge terminée.'
  end

  def validate_payment
    @booking = Booking.find(params[:id])
  @booking.valider_paiement!
  redirect_to booking_path(@booking), notice: 'Paiement validé.'
rescue ActiveRecord::RecordNotFound
  redirect_to root_path, alert: "Réservation introuvable."
end
  private


  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:vehicle_id, :station_id, :date_heure_reservation, :date_heure_fin_de_reservation)
  end
end
