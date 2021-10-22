class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user).where(status: 1)
  end

  def feed
    @posts = current_user.feed
    @users = User.all.order(created_at: :desc)
  end
end
