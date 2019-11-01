class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :dish_id
      t.integer :from_user_id

      t.timestamps
    end
    add_index :lists, :user_id
  end
end
