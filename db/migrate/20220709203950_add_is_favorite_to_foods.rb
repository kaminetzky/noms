class AddIsFavoriteToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :is_favorite, :boolean, default: false
    change_column :foods, :is_favorite, :boolean, default: nil
  end
end
