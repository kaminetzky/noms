class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.text :description
      t.float :servings
      t.datetime :consumed_on
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
