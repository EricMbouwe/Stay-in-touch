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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :buddies, class_name: 'User', foreign_key: 'friend_id', source: :user, through: :friendships

  # scope :my_friends, ->(user) { where (' ? = true '), is_a_friend(:id, user) }

  def friends
    friends_array = friendships.map { |f| f.friend if f.status == 1 }
    friends_array += inverse_friendships.map { |f| f.user if f.status == 1 }
    friends_array.compact
  end

  def friends_and_myself
    friends_array = [User.find(self.id)]
    friends_array += friendships.map { |f| f.friend if f.status == 1 }
    friends_array += inverse_friendships.map { |f| f.user if f.status == 1 }
    friends_array.compact
  end

  def friends_and_myself_ids
    friends_array = [self.id]
    friends_array += friendships.map { |f| f.friend_id if f.status == 1 }
    friends_array += inverse_friendships.map { |f| f.user_id if f.status == 1 }
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |f| f.friend if f.status == 0 }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |f| f.user if f.status == 0 }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  # def self.is_a_friend(id, user)

  #   fr = Friendship.find_by(user_id: user.id, friend_id: id, status: 1)
  #   return true if fr

  #   fr = Friendship.find_by(user_id: id, friend_id: user.id, status: 1)
  #   return true if fr

  #   false
  # end

end
