class AddUserToMealsAndFoods < ActiveRecord::Migration[7.0]
  def change
    add_reference :foods, :user, null: false, foreign_key: true, default: 1
    add_reference :meals, :user, null: false, foreign_key: true, default: 1
    change_column_default :foods, :user_id, from: 1, to: nil
    change_column_default :meals, :user_id, from: 1, to: nil
  end
end
