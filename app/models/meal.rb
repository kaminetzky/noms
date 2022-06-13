class Meal < ApplicationRecord
  belongs_to :food

  validates :servings, presence: true
  validates :consumed_on, presence: true
  validates :food_id, presence: true
end
