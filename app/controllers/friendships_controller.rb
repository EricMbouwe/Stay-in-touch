class FriendshipsController < ApplicationController
  def update
    user_id = params[:id]
    user = User.find(user_id)

    accept = params[:accept] == 'true'
    caller = params[:caller]

    friendship = Friendship.find_by("friend_id = #{current_user.id} AND user_id = #{user_id}")
    friendship.confirm if accept

    friendship.reject unless accept

    flash.notice = current_user.name + (accept ? ' accepted ' : ' rejected ') + user.name

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'
  end

  def create
    user_id = params[:format]
    user = User.find(user_id)
    caller = params[:caller]

    current_user.invite(user)

    flash.notice = current_user.name + ' invited ' + user.name

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'
  end
end
