class DashboardsController < ApplicationController
  def show
    @meals = Meal.all
    @foods = Food.all

    @meals_today = Meal.today
  end
end
