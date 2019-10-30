class Memo < ApplicationRecord
  belongs_to :dish
  validates :user_id, presence: true
  validates :dish_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
