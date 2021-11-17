class CommentController < ApplicationController
  before_action :authenticate_user!
  before_action :post_user?, only: %i[accept]
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)
    CommentWaitingJob.set(wait: 2.days).perform_later(@comment.id)
    @user_comment = @post.comments.where(user_id: current_user).where(status: 0)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js { @user_comment }
    end
  end

  def accept
    comment = @post.comments.find(params[:comment_id])
    comment_deathline(comment)
    if comment.post.user == current_user
      if comment.locked
        flash[:warn] = 'Processing time is over.'
      else
        comment.update!(status: params[:status_id])
        flash[:notice] = 'Process successfully.'
      end
    else
      flash[:warn] = 'Unauthorized process.'
    end
    redirect_to dashboard_path
  end

  private

  def post_user?
    post = Post.find(params[:post_id])
    unless post.user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't permission to page" }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :content).merge(user: current_user)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_deathline(comment)
    if (Time.now - comment.created_at) - 172800 > 0
        comment.update!(locked: true)
        if comment.status == 0
            comment.update(status: 1)
        end
    end
end
end
