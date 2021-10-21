class WelcomeController < ApplicationController
  def index
    redirect_to user_feed_path if current_user
  end

end
