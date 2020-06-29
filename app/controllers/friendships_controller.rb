class FriendshipsController < ApplicationController
  def update
    user_id = params[:id]
    user = User.find(user_id)

    accept = params[:accept] == 'true'
    caller = params[:caller]

    current_user.confirm_friend(user) if accept
    current_user.reject_friend(user) unless accept

    # friendship = Friendship.find_by("friend_id = #{current_user.id} AND user_id = #{user_id}")
    # friendship.status = accept ? 1 : -1
    # friendship.save

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'
  end

  def create
    user_id = params[:format]
    user = User.find(user_id)
    caller = params[:caller]

    current_user.friendships.create(friend_id: user_id)

    flash.notice = current_user.name + ' invited ' + user.name

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'
  end
end
