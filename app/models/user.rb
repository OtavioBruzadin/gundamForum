class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Relacionamento de quem está seguindo
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :following

  # Relacionamento de seguidores
  has_many :passive_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  def following?(user)
    following.exists?(user.id)
  end
end
