class CreateBadges < ActiveRecord::Migration[7.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image
      t.time :duration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
