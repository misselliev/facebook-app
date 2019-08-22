class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :friendships, dependent: :destroy

  validates :name, presence: :true, length: {minimum: 3, maximum: 50}
  validates :lastname, presence: :true, length: {minimum: 3, maximum: 50}
  validates :password, presence: :true, length: {minimum: 6, maximum: 15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  def downcase_email
    email.downcase!
  end
end
