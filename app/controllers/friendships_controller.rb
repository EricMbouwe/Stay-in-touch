class FriendshipsController < ApplicationController

  def update 
    user_id = params[:id]
    accept = params[:accept] == 'true' ? true : false
    # user = User.find(user_id)
    # status = 
    # flash.notice = params
    # user.name + " was Invited by " + current_user.name

    friendship = Friendship.find_by("user_id = #{current_user.id} AND friend_id = #{user_id}")
    friendship.status = accept ? 1 : -1
    friendship.save

    # flash.notice = friendship

    redirect_to users_path
  end

  def create

  end

end
