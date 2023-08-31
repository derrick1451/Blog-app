class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  def likes_counter
    post.increament!(:LikesCounter)
  end
end
