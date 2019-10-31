class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :dish_id
      t.integer :variety

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
