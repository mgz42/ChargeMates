class AddWheelToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wheel, :datetime
  end
end
