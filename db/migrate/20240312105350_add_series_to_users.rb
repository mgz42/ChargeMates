class AddSeriesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :seriestart, :datetime
    add_column :users, :seriecurrent, :datetime
  end
end
