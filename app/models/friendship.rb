class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate :already_requested


  scope :confirmed, -> { where('confirmed = ?', true) }
  scope :pending, -> { where(confirmed: nil) }
  scope :pending_with_friend_id, ->(user) { where(friend_id: user, confirmed: nil) }

  def already_requested
    friend_forward_validation = Friendship.where(user_id: friend_id, friend_id: user_id).exists?
    friend_reverse_validation = Friendship.where(user_id: user_id, friend_id: friend_id).exists?
    unless friend_forward_validation || friend_reverse_validation 
      self.errors.add(:user_id, 'Already requested!')
    end
  end

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
