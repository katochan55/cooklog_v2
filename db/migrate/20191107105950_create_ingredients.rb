class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :dish_id
      t.string :name
      t.string :quantity

      t.timestamps
    end
    add_index :ingredients, :dish_id
  end
end
