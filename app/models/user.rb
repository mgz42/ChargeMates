class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vehicles
  has_many :vehicle_bookings, through: :vehicles, source: :bookings
  has_one :station
  has_many :station_bookings, through: :station, source: :bookings
  has_many :badges
  has_many :messages
  has_many :conflicts
  has_many :bookings
  has_many :bookings, through: :vehicles
  has_one_attached :photo

  validates :email, presence: true, uniqueness: true
  validates :wheel, presence: true
  validates :encrypted_password, presence: true
  validates :username, presence: true
  validates :xp, presence: true

  # Méthode pour récupérer toutes les réservations associées à cet utilisateur.
  def bookings_for_current_user
    # Récupère les réservations liées aux véhicules de l'utilisateur
    vehicle_reservations = Booking.where(vehicle_id: vehicles.ids)

    # Récupère les réservations liées à la station de l'utilisateur
    station_reservations = Booking.where(station_id: station.id) if station.present?

    # Combine les deux ensembles de réservations
    vehicle_reservations.or(station_reservations)
  end

  def est_un_customer?
    self.station.nil?
  end

end
