class RemoveImagesFromBadges < ActiveRecord::Migration[7.1]
  def change
    remove_column :badges, :image
  end
end
