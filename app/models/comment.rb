class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :comments_counter

  private

  def comments_counter
    post.increament!(:comments_counter)
  end
end
