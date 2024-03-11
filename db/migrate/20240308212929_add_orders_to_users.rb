class AddOrdersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :orders, :integer
  end
end
