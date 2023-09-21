class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comment = Comment.new
    @user = current_user
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def destroy
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:post_id])
    @comment = @post.comments

    if @comment.destroy
      redirect_to user_post_path(
        @user, @post
      ), notice: 'Comment deleted successfully!'
    else
      redirect_to user_post_path(@userz, @post), alert: 'Error: Comment could not be deleted'
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    respond_to do |format|
      format.html do
        if @comment.save
          flash[:success] = 'comments saved successfully'
          redirect_to user_post_url(current_user, @post)
        else
          flash.now[:error] = 'Error: comment could not be saved'
          render :new
        end
      end
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:Text) # Use capital T and capital T
  end
end
