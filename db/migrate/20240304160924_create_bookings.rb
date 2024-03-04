class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :date_heure_reservation
      t.date :date_heure_debut_recharge
      t.time :duree_recharge
      t.date :date_heure_fin_recharge
      t.string :status
      t.references :vehicle, null: false, foreign_key: true
      t.references :station, null: false, foreign_key: true

      t.timestamps
    end
  end
end
