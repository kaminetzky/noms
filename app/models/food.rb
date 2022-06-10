class Food < ApplicationRecord
  validates :name, presence: true
  validates :serving_size, comparison: { greater_than_or_equal_to: 0 },
    allow_nil: true
  validates :calories, comparison: { greater_than_or_equal_to: 0 }
  validates :protein, comparison: { greater_than_or_equal_to: 0 }
end
