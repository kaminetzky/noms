class MealsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if current_user.nil?
      @meals = Meal.all
    else
      @meals = Meal.where(user: current_user)
    end
    @calendar, @pagy, @meals = pagy_calendar(@meals.order(consumed_on: :desc), year: {}, month: {}, day: {})
  end

  def show
    @meal = Meal.find(params[:id])
    @is_meal_owner = @meal.user == current_user
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

    if @meal.user == current_user
      @foods = Food.where(user: current_user).order(:name)
    else
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    end
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.user == current_user
      if @meal.update(meal_params)
        redirect_to @meal
      else
        @foods = Food.where(user: current_user).order(:name)
        render :edit, status: :unprocessable_entity
      end
    else
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    end
  end

  def destroy
    @meal = Meal.find(params[:id])

    if @meal.user == current_user
      @meal.destroy
      redirect_to meals_path, status: :see_other
    else
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:notes, :servings,
                                  :consumed_on, :food_id)
  end

  def pagy_calendar_period(collection)
    starting = collection.minimum('consumed_on')
    ending = collection.maximum('consumed_on')
    [starting.in_time_zone, ending.in_time_zone]
  end

  def pagy_calendar_filter(collection, from, to)
    collection.where(consumed_on: from...to)
  end
end
