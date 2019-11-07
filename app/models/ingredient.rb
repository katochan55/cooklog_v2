class Ingredient < ApplicationRecord
  belongs_to :dish
  validates :dish_id, presence: true
  validates :name, presence: true
end
