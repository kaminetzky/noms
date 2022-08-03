class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if current_user.nil?
      @foods = Food.order(:name)
    else
      @foods = Food.where(user: current_user).order(:name)
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to @food
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @food = Food.find(params[:id])

    render file: "#{Rails.root}/public/403.html", layout: false, status: 403 \
      unless @food.user == current_user
  end

  def update
    @food = Food.find(params[:id])

    if @food.user == current_user
      if @food.update(food_params)
        redirect_to @food
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.user == current_user
      @food.destroy
      redirect_to foods_path, status: :see_other
    else
      render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    end
  end

  private
    def food_params
      params.require(:food).permit(:name, :notes, :serving_size,
                                   :serving_unit, :calories, :protein,
                                   :is_favorite)
    end
end
