class List < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :dish_id, presence: true
  validates :from_user_id, presence: true
end
