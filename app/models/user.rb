# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :name, presence: :true, length: { minimum: 3, maximum: 50 }
  validates :lastname, presence: :true, length: { minimum: 3, maximum: 50 }
  validates :password, presence: :true, length: { minimum: 6, maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  def downcase_email
    email.downcase!
  end

  def self.confirm_friendship?(friend_request = nil)
    if friend_request 
      friend_request.confirmed = true
      user = User.find_by_id(friend_request.friend_id)
      user.friendships.build(friend_id: friend_request.user_id, confirmed: true).save
    else
      user = User.find_by_id(friend_request.friend_id)
      user.friendships.build(friend_id: friend_request.user_id, confirmed: false).save
    end
  end
end
