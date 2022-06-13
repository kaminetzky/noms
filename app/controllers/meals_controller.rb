class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new(servings: 1, consumed_on: Time.now)
    @foods = Food.all
  end

  def create
    @meal = Meal.new(meal_params)
    @foods = Food.all

    if @meal.save
      redirect_to @meal
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    @foods = Food.all
  end

  def update
    @meal = Meal.find(params[:id])
    @foods = Food.all

    if @meal.update(meal_params)
      redirect_to @meal
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path, status: :see_other
  end

  private
    def meal_params
      params.require(:meal).permit(:description, :servings,
                                   :consumed_on, :food_id)
    end
end
