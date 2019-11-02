class Log < ApplicationRecord
  belongs_to :dish
  validates :dish_id, presence: true
end
