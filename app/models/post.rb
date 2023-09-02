class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'
  validates :Title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :LikesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:PostsCounter)
  end
end
