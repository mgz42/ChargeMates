class ChangeDatesFromBookings < ActiveRecord::Migration[7.1]
  def change
    change_column(:bookings, :date_heure_reservation, :datetime)
    change_column(:bookings, :date_heure_debut_recharge, :datetime)
    change_column(:bookings, :date_heure_fin_recharge, :datetime)
  end
end
