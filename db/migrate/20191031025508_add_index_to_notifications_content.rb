class AddIndexToNotificationsContent < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :content, :text
  end
end
