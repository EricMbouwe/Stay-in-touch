class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm
    update_attributes(status: 1)
    Friendship.create!(friend_id: user_id, user_id: friend_id, status: 1)
  end

  def reject
    update_attributes(status: -1)
  end
end
