class AddDureeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :duree_recharge, :float
  end
end
