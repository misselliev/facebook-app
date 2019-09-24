# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate :already_requested, on: :create
  validate :friendship_true?, on: :confirm_friendship

  scope :confirmed, -> { where('confirmed = ?', true) }
  scope :pending, -> { where(confirmed: nil) }
  scope :pending_with_friend_id, ->(user) { where(friend_id: user, confirmed: nil) }
  scope :is_my_friend?, ->(friend) { where(friend_id: friend, confirmed: true) }
  scope :is_a_pending, ->(friend) { where(friend: friend, confirmed: nil) }

  def already_requested
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id} AND confirmed IS NULL",
                    "user_id = #{friend_id} AND friend_id = #{user_id} AND confirmed IS NULL"]
    errors.add(:user_id, 'already requested') if Friendship.where(combinations.join(' OR ')).exists?
  end

  def friendship_true?
    combinations = ["user_id = #{user_id} AND friend_id = #{friend_id} AND confirmed = true",
                    "user_id = #{friend_id} AND friend_id = #{user_id} AND confirmed = true"]

    find_friend = proc { |user_id, friend_id| Friendship.find(user_id: user_id, friend_id: friend_id) }

    return unless Friendship.where(combinations.join(' OR ')).exists?

    friend_request = find_friend.call(user_id, friend_id) || find_friend.call(friend_id, user_id)
    inverted_friendship(friend_request)
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

  def self.confirm_friendship(friend_request)
    friend_request = Friendship.find_by_id(friend_request)
    friend_request.update(confirmed: true)
    friend_request.save
    inverted_friendship(friend_request)
  end

  def self.inverted_friendship(friend_request)
    user = User.find_by_id(friend_request.friend_id)
    user.friendships.build(friend_id: friend_request.user_id, confirmed: friend_request.confirmed).save
  end
end
