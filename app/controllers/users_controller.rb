class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # @friendship
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
    @pending_friends = @user.pending_friends
    @friend_requests = @user.friend_requests

    @status = get_friendships_status(current_user.id, @user.id)
  end
end
