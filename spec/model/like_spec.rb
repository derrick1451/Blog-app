require 'rails_helper'

RSpec.describe Like, type: :model do
  first_user = User.create(Name: 'Tom', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Teacher from Mexico.')
  first_post = Post.create(author: first_user, Title: 'Hello', Text: 'This is my first post')
  subject { Like.new(post: first_post, author: first_user) }

  before { subject.save }

  it 'is valid with correct attributes' do
    expect(subject).to be_valid
  end

  describe '#update_likes_counter' do
    it 'increments the post\'s likes_counter' do
      expect { subject.likes_counter }.to change { subject.post.LikesCounter }.by(1)
    end
  end
end
