class AddCommentSupplyToStations < ActiveRecord::Migration[7.1]
  def change
    add_column :stations, :comment_supply, :string
  end
end
