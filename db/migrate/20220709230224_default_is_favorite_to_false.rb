class DefaultIsFavoriteToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column :foods, :is_favorite, :boolean, default: nil
  end
end
