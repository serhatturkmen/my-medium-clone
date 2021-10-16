class WelcomeController < ApplicationController
  def index
    @posts = Post.availables
  end

  def user_page
    @user = User.find(params[:id])
  end
end
