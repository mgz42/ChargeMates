class ChangeDurationFromBadges < ActiveRecord::Migration[7.1]
  def change
    remove_column :badges, :duration
    add_column :badges, :duration, :datetime
  end
end
