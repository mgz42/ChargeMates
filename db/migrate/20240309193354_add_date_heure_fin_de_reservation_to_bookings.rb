class AddDateHeureFinDeReservationToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :date_heure_fin_de_reservation, :datetime
  end
end
