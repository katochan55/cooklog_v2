class AddIndexToUsersNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notification, :boolean, default: false
  end
end
