class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # @friendship
    @users = User.find_by_sql("SELECT users.*, fri.status AS outer_status, 
                                          fra.status AS inner_status  
                          FROM users 
                          LEFT JOIN friendships fri ON users.id = fri.friend_id 
                          LEFT JOIN friendships fra ON users.id = fra.user_id")
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
