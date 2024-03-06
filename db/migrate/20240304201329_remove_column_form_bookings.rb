class RemoveColumnFormBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :duree_recharge
  end
end
