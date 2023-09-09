class PostsController < ApplicationController
  def index
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts
  end

  def show
    # @post = Post.find(params[:id])
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts
    @post = @posts.find(params[:id])
  end
end
