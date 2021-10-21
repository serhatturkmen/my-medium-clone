class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user).where(visible: true)
    @comments = Comment.where(user_id: @user).where(accept: true)
  end

  def feed
    @posts = Post.availables
  end
end
