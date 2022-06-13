class Meal < ApplicationRecord
  belongs_to :food

  validates :servings, presence: true
  validates :consumed_on, presence: true
  validates :food_id, presence: true

  def self.today
    # Day starts at 6 AM
    where("consumed_on >= ?", Time.now.beginning_of_day + 6.hours)
  end

  def calories
    servings * food.calories
  end

  def protein
    servings * food.protein
  end
end
