class Post < ApplicationRecord
  has_one_attached :image
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
end
