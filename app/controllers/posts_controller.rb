class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy vote_add vote_reduce ]
  before_action :authenticate_user!
  before_action :check_user, only: %i[edit update destroy]

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.accepted
    @user_comment = @post.comments.where(user_id: current_user).where(status: 0)
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def vote_add
    @post.update(vote_count: @post.vote_count + 1)
    respond_to do |format|
      format.js
    end
  end

  def vote_reduce
    @post.update(vote_count: @post.vote_count - 1)
    respond_to do |format|
      format.js
    end
  end

  private

  def check_user
    unless @post.user == current_user
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "You shall not pass." }
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :visible)
  end
end
