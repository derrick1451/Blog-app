class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :likes_counter

  private

  def likes_counter
    post.increament!(:LikesCounter)
  end
end
