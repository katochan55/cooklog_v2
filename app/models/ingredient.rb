class Ingredient < ApplicationRecord
  belongs_to :dish
  validates :name, presence: true
end
