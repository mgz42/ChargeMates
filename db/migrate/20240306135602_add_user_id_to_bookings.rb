class AddUserIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :user, null: true, foreign_key: true
  end
end
