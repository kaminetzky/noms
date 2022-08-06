class Meal < ApplicationRecord
  belongs_to :food
  belongs_to :user

  validates :servings, comparison: { greater_than_or_equal_to: 0 }
  validates :consumed_on, presence: true
  validates :food_id, presence: true

  def self.last_meals_by_day(days)
    group_by_day(:consumed_on, last: days, format: "%A, %B %-e")
  end

  def self.last_meals_calories_by_day(days)
    last_meals_by_day(days).joins(:food).sum('servings*calories')
  end

  def self.last_meals_protein_by_day(days)
    last_meals_by_day(days).joins(:food).sum('servings*protein')
  end

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
