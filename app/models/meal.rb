class Meal < ApplicationRecord
  belongs_to :food

  validates :servings, comparison: { greater_than_or_equal_to: 0 }
  validates :consumed_on, presence: true
  validates :food_id, presence: true

  def self.today
    # Day starts at 6 AM
    where("consumed_on >= ?",
          (Time.zone.now - 6.hours).beginning_of_day + 6.hours)
  end

  def self.not_today
    # Day starts at 6 AM
    where.not("consumed_on >= ?",
              (Time.zone.now - 6.hours).beginning_of_day + 6.hours)
  end

  def calories
    servings * food.calories
  end

  def protein
    servings * food.protein
  end
end
