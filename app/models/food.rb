class Food < ApplicationRecord
  has_many :meals

  validates :name, presence: true
  validates :serving_size, comparison: { greater_than_or_equal_to: 0 }
  validates :serving_unit, presence: true
  validates :calories, comparison: { greater_than_or_equal_to: 0 }
  validates :protein, comparison: { greater_than_or_equal_to: 0 }
  validates :is_favorite, presence: true

  def serving
    "#{serving_size} #{serving_unit}"
  end
end
