class Meal < ApplicationRecord
  belongs_to :food

  validates :servings, presence: true
  validates :consumed_on, presence: true
  validates :food_id, presence: true

  def self.today
    where("consumed_on >= ?", Time.now.beginning_of_day)
  end

  def calories
    servings * food.calories
  end

  def protein
    servings * food.protein
  end
end
