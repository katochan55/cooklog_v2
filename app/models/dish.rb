class Dish < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 50 }
  validates :tips, length: { maximum: 50 }
end
