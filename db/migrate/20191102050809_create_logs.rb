class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :dish_id
      t.text :content

      t.timestamps
    end
    add_index :logs, :dish_id
  end
end
