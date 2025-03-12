class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true
end


