class FriendshipsController < ApplicationController

  def update 
    user_id = params[:id]
    accept = params[:accept] == 'true' ? true : false
    caller = params[:caller]

    friendship = Friendship.find_by("friend_id = #{current_user.id} AND user_id = #{user_id}")
    friendship.status = accept ? 1 : -1
    friendship.save

    # flash.notice = params

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'

  end

  def create
    user_id = params[:format]
    user = User.find(user_id)
    caller = params[:caller]
    # flash.notice = params

    fr = current_user.friendships.create(friend_id: user_id)
    
    flash.notice = current_user.name + ' invited ' + user.name

    redirect_to users_path if caller == 'index'
    redirect_to user_path(user_id) if caller == 'show'
  end

end
