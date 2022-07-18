class DashboardsController < ApplicationController
  def show
    @meal_count = Meal.count
    @food_count = Food.count

    @calories_today = Meal.today.sum(&:calories).round
    @protein_today = Meal.today.sum(&:protein).round
    @meal_last = Meal.last
    @food_last = Food.last
  end
end
