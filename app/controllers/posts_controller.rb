class PostsController < ApplicationController
  before_action :authenticate_user!  # Ensure users are logged in
  before_action :set_post, only: %i[show edit update destroy update_like]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comment = Comment.new  # Initialize a new comment object
    @comments = @post.comments.includes(:user)  # Load existing comments for the post
  end

  def new
    @post = current_user.posts.build
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully deleted."
  end

  # Comment creation action
  def create_comment
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user  # Assign the current user to the comment

    if @comment.save
      redirect_to @post, notice: "Comment was successfully added."
    else
      redirect_to @post, alert: "Error adding comment."
    end
  end

  def update_like
    # Toggle the like status for the current user and the post
    if current_user.liked_posts.include?(@post)
      # If the user has already liked the post, remove the like
      current_user.likes.find_by(post: @post).destroy
    else
      # Otherwise, create a new like
      current_user.likes.create(post: @post)
    end

    # Respond with a JSON response or redirect
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Like status updated.' }
      format.json { render json: { likes_count: @post.likes.count, liked_by_users: @post.liked_by_users.pluck(:first_name) } }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    redirect_to posts_path, alert: "You're not authorized to edit this post." unless @post.user == current_user
  end
end
