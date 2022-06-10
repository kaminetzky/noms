class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.float :serving_size
      t.string :serving_unit
      t.float :calories
      t.float :protein

      t.timestamps
    end
  end
end
