class CommentController < ApplicationController
  before_action :authenticate_user!
  before_action :is_post_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.update!(user: current_user)
    redirect_to @post
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def accept
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:comment_id])
    if comment.accept
      comment.update!(accept: false)
    else
      comment.update!(accept: true)
    end
    flash[:notice] = 'Process successfully.'
    redirect_to root_path
  end

  private

  def is_post_user
    unless Post.find(params[:post_id]).user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't permission to page" }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
