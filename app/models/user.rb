class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_one_attached :profile_picture
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  # searchkick word_start: [:first_name, :last_name]
  include PgSearch::Model

  pg_search_scope :search_by_name, 
                  against: [:first_name, :last_name],
                  using: {
                    tsearch: { prefix: true } # for "word_start" match
                  }
end
