class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :my_friends, ->(user) { where (' ? = true '), is_a_friend(:id, user) }
  scope :me_and_my_friends, ->(user) { where (' ? = true '), is_me_or_a_friend(:id, user) }
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.is_me_or_a_friend(id, user)
    return true if id = user.id

    fr = Friendship.find_by(user_id: user.id, friend_id: id, status: 1)
    return true if fr

    fr = Friendship.find_by(user_id: id, friend_id: user.id, status: 1)
    return true if fr

    false
  end

  def self.is_a_friend(id, user)

    fr = Friendship.find_by(user_id: user.id, friend_id: id, status: 1)
    return true if fr

    fr = Friendship.find_by(user_id: id, friend_id: user.id, status: 1)
    return true if fr

    false
  end

end
