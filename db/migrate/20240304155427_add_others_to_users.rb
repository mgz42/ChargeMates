class AddOthersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :xp, :integer
  end
end
