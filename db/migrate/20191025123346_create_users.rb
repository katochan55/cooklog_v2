class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :introduction
      t.string :sex

      t.timestamps
    end
  end
end
