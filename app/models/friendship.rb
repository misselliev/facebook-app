class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user_id, presence: true
  validates :friend_id, presence: true

  scope :confirmed, -> { where(confirmed: true) }
  scope :pending, -> { where(confirmed: nil) }
  scope :rejected, -> { where(confirmed: false) }

  def self.get_confirmed(user)
    user.friendships.all.confirmed
  end

  def self.get_pending(user)
    user.friendships.all.pending
  end
end
