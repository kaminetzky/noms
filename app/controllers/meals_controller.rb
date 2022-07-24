class MealsController < ApplicationController
  def index
    @meals = Meal.order(consumed_on: :desc)
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new(servings: 1, consumed_on: Time.now, food_id: params[:food_id])
    @foods = Food.order(:name)
  end

  def create
    @meal = Meal.new(meal_params)
    @foods = Food.order(:name)

    if @meal.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    @foods = Food.order(:name)
  end

  def update
    @meal = Meal.find(params[:id])
    @foods = Food.order(:name)

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
      params.require(:meal).permit(:notes, :servings,
                                   :consumed_on, :food_id)
    end
end
