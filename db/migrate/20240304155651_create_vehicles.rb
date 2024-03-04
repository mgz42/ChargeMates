class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.string :immatriculation
      t.string :plug
      t.integer :max_kW_recharge
      t.integer :model_year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
