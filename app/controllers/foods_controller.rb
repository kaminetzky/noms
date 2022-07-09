class FoodsController < ApplicationController
  def index
    @foods = Food.order(:name)
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to @food
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      redirect_to @food
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, status: :see_other
  end

  private
    def food_params
      params.require(:food).permit(:name, :description, :serving_size,
                                   :serving_unit, :calories, :protein,
                                   :is_favorite)
    end
end
