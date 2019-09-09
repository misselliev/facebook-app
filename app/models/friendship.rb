class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user_id, presence: true
  validates :friend_id, presence: true

  scope :confirmed, -> { where('confirmed = ?', true) }
  scope :rejected, -> { where('confirmed = ?', false) }
  scope :pending, -> { where(confirmed: nil) }

  def self.get_confirmed(user)
    user.friendships.confirmed
  end

  def self.get_rejected(user)
    user.friendships.rejected
  end

  def self.get_pending(user)
    user.friendships.pending
  end

  def self.confirm_friendship?(friend_request, status)
    friend_request = Friendship.find_by_id(friend_request)
    friend_request.confirmed = status
    friend_request.save
    byebug
    inverted_friendship(friend_request)
    # if status 
    #   user = User.find_by_id(friend_request.friend_id)
    #   user.friendships.build(friend_id: friend_request.user_id, confirmed: true).save
    # else
    #   user = User.find_by_id(friend_request.friend_id)
    #   user.friendships.build(friend_id: friend_request.user_id, confirmed: false).save
    # end
  end

  def self.inverted_friendship(friend_request)
    user = User.find_by_id(friend_request.friend_id)
    user.friendships.build(friend_id: friend_request.user_id, confirmed: friend_request.confirmed).save
  end
end
