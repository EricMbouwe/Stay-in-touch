class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :confirmed_friendships, -> { where status: 1 }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where status: 0 }, class_name: 'Friendship'
  has_many :friendship_requests, -> { where status: 0 }, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends_and_myself
    friends_array = [self]
    friends_array += friends
    friends_array.compact
  end

  def friends_and_myself_ids
    friends_array = [id]
    friends_array += friends.map(&:id)
    friends_array.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def friend_or_me?(user)
    return true if user == self

    friends.include?(user)
  end

  def invite(user)
    friendships.create(friend_id: user.id, status: 0)
  end
end
