require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(Title: 'random post', author: User.create(Name: 'derrick'), CommentsCounter: 0, LikesCounter: 0) }

  before { subject.save }

  it 'is valid with correct attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid with a blank title' do
    subject.Title = ''
    expect(subject).not_to be_valid
  end

  it 'is invalid with a title exceeding 250 characters' do
    subject.Title = 'A' * 251
    expect(subject).not_to be_valid
  end

  it 'is invalid if comments_counter is not an integer' do
    subject.CommentsCounter = 1.24
    expect(subject).not_to be_valid
  end

  it 'is not valid if comments_counter is negative' do
    subject.CommentsCounter = -2
    expect(subject).not_to be_valid
  end

  it 'is invalid if likes_counter is not an integer' do
    subject.LikesCounter = 1.24
    expect(subject).not_to be_valid
  end

  it 'is not valid if likes_counter is negative' do
    subject.LikesCounter = -2
    expect(subject).not_to be_valid
  end

  describe '#update_author_posts_counter' do
    it 'increments the author\'s posts_counter' do
      expect { subject.update_post_counter }.to change { subject.author.PostsCounter }.by(1)
    end
  end

  describe '#top_five_comments' do
    it 'returns the five most recent comments' do
      user = User.create(Name: 'Derrick')
      Comment.create(author: user, post: subject, Text: 'comment1', created_at: 5.days.ago)
      comment2 = Comment.create(author: user, post: subject, Text: 'comment2', created_at: 4.days.ago)
      comment3 = Comment.create(author: user, post: subject, Text: 'comment3', created_at: 3.days.ago)
      comment4 = Comment.create(author: user, post: subject, Text: 'comment4', created_at: 2.days.ago)
      comment5 = Comment.create(author: user, post: subject, Text: 'comment5', created_at: 1.day.ago)
      comment6 = Comment.create(author: user, post: subject, Text: 'comment6', created_at: Time.now)

      result = subject.five_most_recent_comments

      expected_order = [comment6, comment5, comment4, comment3, comment2]

      expect(result).to eq(expected_order)
    end
  end
end
