class CreateStations < ActiveRecord::Migration[7.1]
  def change
    create_table :stations do |t|
      t.string :address
      t.string :plug
      t.string :brand
      t.string :model
      t.float :parking_price
      t.float :consomation_price
      t.integer :max_kW_recharge
      t.boolean :available
      t.date :avaibility_end
      t.integer :code_station
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
