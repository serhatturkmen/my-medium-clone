class CommentController < ApplicationController
  before_action :authenticate_user!
  before_action :is_post_user, only: %i[accept]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.update!(user: current_user)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
    # redirect_to @post
  end

  def accept
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:comment_id])
    if comment.post.user.eql?(current_user)
      comment.update!(status: params[:status_id])
      flash[:notice] = 'Process successfully.'
    else
      flash[:warn] = 'Unauthorized process.'
    end
    redirect_to dashboard_path
  end

  private

  def is_post_user
    post = Post.find(params[:post_id])
    unless post.user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't permission to page" }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
