class MealsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @meals = Meal.where(user: current_user).order(consumed_on: :desc)
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new(servings: 1, consumed_on: Time.now, food_id: params[:food_id])
    @foods = Food.where(user: current_user).order(:name)
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to root_path
    else
      @foods = Food.where(user: current_user).order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    @foods = Food.where(user: current_user).order(:name)
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      redirect_to @meal
    else
      @foods = Food.where(user: current_user).order(:name)
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
