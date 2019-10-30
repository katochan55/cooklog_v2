class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.integer :dish_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index :memos, :user_id
    add_index :memos, :dish_id
  end
end
