# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :author, presence: true

  belongs_to :friend, class_name: 'User'
  validates :friend, presence: true

  has_many :comments
  has_many :likes

  validates :content, presence: true, length: { minimum: 1, maximum: 500 }
  scope :recent_posts, -> { where('created_at < ?', Time.current).order(created_at: :DESC) }
  scope :mine_and_friends, ->(user) { where(friend_id: user).or(Post.where(author_id: user)).order(created_at: :DESC) }
  scope :last_five_posts, -> { where('created_at < ?', Time.current).order(created_at: :DESC).limit(5) }
end
