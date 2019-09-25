class AddFriendIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :friend_id, :integer
  end
end
