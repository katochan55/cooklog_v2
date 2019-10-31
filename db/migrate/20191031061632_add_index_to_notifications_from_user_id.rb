class AddIndexToNotificationsFromUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :from_user_id, :integer
  end
end
