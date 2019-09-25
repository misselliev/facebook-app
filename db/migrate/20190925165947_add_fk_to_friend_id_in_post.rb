class AddFkToFriendIdInPost < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :posts, :users, column: :friend_id
  end
end
