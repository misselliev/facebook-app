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
end
