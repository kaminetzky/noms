class DashboardsController < ApplicationController
  def show
    if current_user.nil?
      meals_user = Meal.all
    else
      meals_user = Meal.where(user: current_user)
    end

    calories_last_days = meals_user.last_meals_calories_by_day(7)
    protein_last_days = meals_user.last_meals_protein_by_day(7)

    @calories_today = calories_last_days.values[-1]
    @protein_today = protein_last_days.values[-1]
    @meal_last = meals_user.order(:consumed_on).last
  end
end
