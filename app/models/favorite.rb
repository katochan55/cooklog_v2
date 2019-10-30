class Favorite < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :dish_id, presence: true
end
