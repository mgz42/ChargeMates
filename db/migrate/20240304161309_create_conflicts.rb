class CreateConflicts < ActiveRecord::Migration[7.1]
  def change
    create_table :conflicts do |t|
      t.string :title
      t.string :content
      t.string :resolution
      t.references :booking, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
