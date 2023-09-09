class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:Text))
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
end
