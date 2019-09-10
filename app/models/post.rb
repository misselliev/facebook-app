class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :content, presence: :true, length: {minimum: 1, maximum: 500}
  scope :recent_posts, -> { where('created_at < ?', Time.current).order(created_at: :DESC) }
  scope :last_five_posts, -> { where('created_at < ?', Time.current).order(created_at: :DESC).limit(5) }

end
