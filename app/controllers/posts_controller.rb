class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts.includes(:comments).order(created_at: :desc)
  end

  def show
    # @post = Post.find(params[:id])
    @user_post = User.find(params[:user_id])
    @posts = @user_post.posts
    @post = @posts.find(params[:id])
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end
  
  def delete
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
    authorize! :destroy, @post

    if @post.destroy
      redirect_to user_posts_path(@user), notice: 'Post deleted successfully!'
    else
      redirect_to user_posts_path(@user), alert: 'Error: Post could not be deleted'
    end
  end

  def create
    @post = current_user.posts.new(params.require(:post).permit(:Title, :Text))
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'post created succesfully'
          redirect_to user_posts_url(current_user)
        else
          flash.now[:error] = "Error: post couldn't be created"
          render :new, locals: { post: @post }
        end
      end
    end
  end
end
