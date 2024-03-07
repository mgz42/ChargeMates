class RemoveUserIdFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :user_id
  end
end
