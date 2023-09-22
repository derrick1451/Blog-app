class Api::V1::PostsController < ApplicationController
  def index
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts.includes(:comments).order(created_at: :desc)
    render json: @posts
  end
end
