class Notification < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :dish_id, presence: true
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
end
