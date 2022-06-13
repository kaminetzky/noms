class DashboardsController < ApplicationController
  def show
    @meals = Meal.all
    @foods = Food.all
  end
end
