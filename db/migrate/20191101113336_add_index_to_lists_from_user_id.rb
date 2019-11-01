class AddIndexToListsFromUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :from_user_id, :integer
  end
end
