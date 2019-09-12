class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :confirmed, -> { where('confirmed = ?', true) }
  scope :pending, -> { where(confirmed: nil) }
  scope :pending_with_friend_id, ->(user) { where(friend_id: user, confirmed: nil) }
  scope :current_friend, ->(friend) { where(user_id: friend, confirmed: nil) }

  def self.get_confirmed(user)
    user.friendships.confirmed
  end

  def self.get_pending(user)
    user.friendships.pending
  end

  def self.get_pending_with_friend_id(user)
    user.friendships.pending_with_friend_id
  end

  def self.confirm_friendship(friend_request, status)
    friend_request = Friendship.find_by_id(friend_request)
    friend_request.update(confirmed: status)
    friend_request.save
    inverted_friendship(friend_request)
  end

  def self.inverted_friendship(friend_request)
    user = User.find_by_id(friend_request.friend_id)
    user.friendships.build(friend_id: friend_request.user_id, confirmed: friend_request.confirmed).save
  end
end
