class Api::V1::CommentsController < ApplicationController
  def index
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts.find(params[:post_id])
    @comments = @posts.comments
    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:Text) # Use capital T and capital T
  end
end
