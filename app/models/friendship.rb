class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    # inverse_friendship = inverse_friendships.find { |f| f.user == user }
    # inverse_friendship.status = 1
    # inverse_friendship.save
    # friendships.create(friend_id: user.id, status: 1)
    self.update_attributes(status: 1)
    Friendship.create!(friend_id: self.user_id, user_id: self.friend_id, status: 1)
  end

  def reject_friend
    # inverse_friendship = inverse_friendships.find { |f| f.user == user }
    # inverse_friendship.status = -1
    # inverse_friendship.save
    self.update_attributes(status: -1)
  end
end
