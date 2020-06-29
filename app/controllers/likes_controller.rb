class LikesController < ApplicationController
  def create
    caller = params[:caller]
    post = Post.find(params[:post_id])
    post_user = post.user
    path = caller == 'user' ? user_path(post_user) : posts_path

    @like = current_user.likes.new(post_id: params[:post_id])

    if @like.save
      redirect_to path, notice: 'You liked a post.'
    else
      redirect_to path, alert: 'You cannot like this post.'
    end
  end

  def destroy
    caller = params[:caller]
    post = Post.find(params[:post_id])
    post_user = post.user
    path = caller == 'user' ? user_path(post_user) : posts_path

    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      redirect_to path, notice: 'You disliked a post.'
    else
      redirect_to path, alert: 'You cannot dislike post that you did not like before.'
    end
  end
end
