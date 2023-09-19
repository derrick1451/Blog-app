require 'rails_helper'

RSpec.describe 'Posts Index Page', type: :system do
  before(:each) do
    @user = User.create(Name: 'Derrick')

    @post1 = @user.posts.create(Title: 'Sample Post Title', Text: 'Sample Post Content')
    @post2 = @user.posts.create(Title: 'Sample Post Title2', Text: 'Sample Post Content')

    Comment.create(post: @post1, author: @user, Text: 'Sample Post Comment')
    Like.create(post: @post1, author: @user)
  end

  describe 'displays user information:' do
    before { visit user_posts_path(@user) }

    it 'show profile picture of user' do
      expect(page).to have_content(@user.Photo)
    end

    it 'show the name of user' do
      expect(page).to have_content(@user.Name)
    end

    it 'show number of posts of user' do
      expect(page).to have_content(@user.PostsCounter)
    end
  end

  describe 'displays all user posts' do
    before { visit user_posts_path(@user) }

    it 'shows all elements of a post' do
      @user.posts.each do |post|
        expect(page).to have_content(post.Text)
        expect(page).to have_content("Comments: #{post.CommentsCounter}")
        expect(page).to have_content("Likes: #{post.LikesCounter}")
      end
    end

    it 'shows the first comment on a post' do
      expect(page).to have_content(@post2.comments.first)
    end
  end

  describe 'links attached to the page' do
    before { visit user_posts_path(@user) }

    it 'redirects to the post show page when clicking on a post' do
      post = @post1
      click_link post.id
      expect(page).to have_current_path(user_post_path(@user, post))
    end
  end
end
