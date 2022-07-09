module FoodsHelper
  def group_by_favorite(foods)
    foods.group_by(&:is_favorite)
         .map { |k, v| { is_favorite: k, foods: v } }.reverse
  end
end
