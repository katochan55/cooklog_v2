class Dish < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  has_many :memos, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :tips, length: { maximum: 50 }
  validate  :picture_size

  # 引数のdish_idを持つメモを集めてくる
  def feed_memo(dish_id)
    Memo.where("dish_id = ?", dish_id)
  end

  private
  # アップロードされた画像のサイズを制限する
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
