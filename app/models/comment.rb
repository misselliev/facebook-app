# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'User'

  validates :content, presence: true, length: { minimum: 2, maximum: 500 }
  validates :commenter_id, presence: true
  validates :post_id, presence: true
  scope :recent_comments, -> { where('created_at < ?', Time.current).order(created_at: :ASC) }
end
