class RemovePriceFromStation < ActiveRecord::Migration[7.1]
  def change
    remove_column :stations, :consomation_price
    remove_column :stations, :parking_price
  end
end
