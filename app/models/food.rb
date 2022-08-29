class Food < ApplicationRecord
  has_many :meals, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :serving_size, comparison: { greater_than_or_equal_to: 0 }
  validates :serving_unit, presence: true
  validates :calories, comparison: { greater_than_or_equal_to: 0 }
  validates :protein, comparison: { greater_than_or_equal_to: 0 }
end
