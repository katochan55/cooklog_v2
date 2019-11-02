class AddIndexToDishesCookMemo < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :cook_memo, :text
  end
end
