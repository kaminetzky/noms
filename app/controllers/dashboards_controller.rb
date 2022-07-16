class DashboardsController < ApplicationController
  def show
    @meal_count = Meal.count
    @food_count = Food.count

    @meals_today = Meal.today
    @meal_last = Meal.last
    @food_last = Food.last
  end
end
