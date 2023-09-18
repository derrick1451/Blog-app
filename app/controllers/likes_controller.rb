class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)

    if @like.save
      redirect_to user_post_path(current_user, @post)
    else
      redirect_to user_post_path(current_user, @post), alert: 'Failed to like the post.'
    end
  end
end
