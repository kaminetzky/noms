class DashboardsController < ApplicationController
  def show
    if current_user.nil?
      meals_user = Meal.all
    else
      meals_user = Meal.where(user: current_user)
    end

    @calories_today = meals_user.today.sum(&:calories).round
    @protein_today = meals_user.today.sum(&:protein).round
    @meal_last = meals_user.last
  end
end
