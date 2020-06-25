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
    @status = nil
    fr = Friendship.find_by(user_id: current_user.id, friend_id: @user.id)
    if fr 
      status = fr.status
      if status == 0
        @status = 'Pending'
      elsif status == 1
        @status = 'Friends'
      else
        @status = @user.name + ' Rejected Friendship'
      end
    else
      fr = Friendship.find_by(user_id: @user.id, friend_id: current_user.id)
      if fr 
        status = fr.status
        if status == 0
          @status = 'Deciding'
        elsif status == 1
          @status = 'Friends'
        else
          @status = 'I Rejected Friendship'
        end
      end
    end
  end
end




