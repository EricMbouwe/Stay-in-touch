class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.find_by_sql("SELECT users.id,
                                        users.name,
                                        fri.status AS outer_status,
                                        fra.status AS inner_status
                              FROM users
                              LEFT JOIN (SELECT * FROM friendships
                                        WHERE friend_id = #{current_user.id}) fri
                                      ON users.id = fri.user_id
                              LEFT JOIN (SELECT * FROM friendships
                                        WHERE user_id = #{current_user.id}) fra
                                      ON users.id = fra.friend_id
                              ORDER BY users.name")
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = @user.friends
    @pending_friendships = @user.pending_friendships
    @friendship_requests = @user.friendship_requests
    @outer_status = outer_status(@user)
    @inner_status = inner_status(@user)
    @caller = 'user'
  end

  private

  def outer_status(user)
    fr = Friendship.find_by(user_id: user.id, friend_id: current_user.id)
    return fr.status unless fr.nil?

    nil
  end

  def inner_status(user)
    fr = Friendship.find_by(user_id: current_user.id, friend_id: user.id)
    return fr.status unless fr.nil?

    nil
  end
end
