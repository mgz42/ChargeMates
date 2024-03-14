class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :update, :destroy]

  def index
    # Pour récupérer les véhicules et la station de l'utilisateur actuel
    user_vehicles = current_user.vehicles
    user_station = current_user.station
    user_vehicles_ids = Vehicle.where(user_id: params[:user_id]).pluck(:id)
    station_bookings = current_user.station.bookings.where.not(status: 'en_attente_de_confirmation') if current_user.station.present?
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

    @booking.status = 'en_attente_de_confirmation'

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
      when "en_attente_de_confirmation" then confirm_offer
      when "en_attente_de_soumission" then submit_offer
      when "en_attente_de_validation" then accept_offer
      when "en_attente_de_paiement" then validate_payment
      when "en_attente_de_charge" then start_charge
      when "en_charge" then stop_charge
    end
    ActionBookingChannel.broadcast_to(
      @booking, {
        owner: render_to_string(partial: "bookings/action_choice", locals: { booking: @booking, is_owner: true } ),
        customer: render_to_string(partial: "bookings/action_choice", locals: { booking: @booking, is_owner: false } ),
        # messages: render_to_string(partial: "messages/message", locals: { booking: @booking }, formats: [:html])

      }
    )
  end

  def destroy
    @booking.destroy
    redirect_to user_path(current_user)
  end

  private



  def check_and_return(booking)
    if booking.status == "en_attente_de_confirmation"
      booking.update(booking_params)
      booking.initier_offre!
      redirect_to booking_path(booking)
      return
    end
  end

  def confirm_offer
    @booking.confirmer_offre!
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
