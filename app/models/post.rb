class Post < ApplicationRecord
    has_many :comments
    has_many :likes
    belongs_to :author, class_name: 'User'

    def five_most_recent_comments
        comments.order(created_at: :desc).limit(5)
    end
    def update_post_counter
        author.increament!(:PostsCounter)
        
    end
end