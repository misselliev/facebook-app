class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate :already_requested, on: :create
  validate :friendship_true?, on: :confirm_friendship


  scope :confirmed, -> { where('confirmed = ?', true) }
  scope :pending, -> { where(confirmed: nil) }
  scope :pending_with_friend_id, ->(user) { where(friend_id: user, confirmed: nil) }

  def already_requested
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id} AND confirmed IS NULL",
                    "user_id = #{friend_id} AND friend_id = #{user_id} AND confirmed IS NULL"]
    if Friendship.where(combinations.join(' OR ')).exists?
      errors.add(:user_id, 'already requested')
    end
  end

  def friendship_true?
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id} AND confirmed = true",
                    "user_id = #{friend_id} AND friend_id = #{user_id} AND confirmed = true"]
                    byebug
    if Friendship.where(combinations.join(' OR ')).exists?
      byebug
      friend_request = Friendship.find(user_id: user_id, friend_id: friend_id) || Friendship.find(user_id: friend_id, friend_id: user_id)
      byebug
      inverted_friendship(friend_request)
      byebug
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
    friend_request.update(confirmed: status) unless friend_request.confirmed = true
    friend_request.save
    inverted_friendship(friend_request)
  end

  def self.inverted_friendship(friend_request)
    user = User.find_by_id(friend_request.friend_id)
    user.friendships.build(friend_id: friend_request.user_id, confirmed: friend_request.confirmed).save
  end
end
