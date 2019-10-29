class AddPictureToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :picture, :string
  end
end
