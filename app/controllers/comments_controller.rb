class CommentsController < ApplicationController
  def create
    post_id = params[:post_id]
    @comment = Comment.new(comment_params)
    @comment.post_id = post_id
    @comment.user = current_user
    caller = params[:caller]

    post_user = Post.find(post_id).user
    path = caller == 'user' ? user_path(post_user) : posts_path

    if @comment.save
      redirect_to path, notice: 'Comment was successfully created.'
    else
      redirect_to path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
