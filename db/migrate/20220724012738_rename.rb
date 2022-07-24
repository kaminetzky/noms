class Rename < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :description, :notes
    rename_column :meals, :description, :notes
  end
end
