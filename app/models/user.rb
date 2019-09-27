# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_many :confirmed, -> { where(confirmed: true) }, class_name: 'Friendship'
  has_many :friends, through: :confirmed

  has_many :pending_friendships, ->(user) { where(confirmed: nil, user: user) }, class_name: 'Friendship',
                                                                                 foreign_key: 'user_id'
  has_many :inverted_pending, ->(user) { where(confirmed: nil, friend: user) }, class_name: 'Friendship',
                                                                                foreign_key: 'friend_id'

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :lastname, presence: true, length: { minimum: 3, maximum: 50 }
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  def downcase_email
    email.downcase!
  end

  def news_feed
    a = Post.where(author: friends + [self]).mine_and_friends(self)
    b = Post.where(author: friends + [self]).recent_posts
    c = a + b
    c.uniq!
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name.split(' ')[0]
      user.lastname = auth.info.name.split[1..-1].join(' ')
      user.image = auth.info.image
      user.save!
    end
  end
end
