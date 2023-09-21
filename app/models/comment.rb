class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :comments_counter
  after_destroy :decrement_comments_counter

  def comments_counter
    post.increment!(:CommentsCounter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
