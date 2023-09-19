require 'rails_helper'

RSpec.describe 'user index view page', type: :system do
  let!(:user1) do
    User.create(
      Name: 'test user1',
      Photo: 'https://lumiere-a.akamaihd.net/v1/images/ct_cinderella_upcportalreskin_20694_f7c876a1.jpeg?region=0,0,330,330',
      Bio: 'Mic testing one two one two',
      PostsCounter: 1
    )
  end

  let!(:post1) do
    Post.create(author: user1, Title: 'Post 1', Text: 'Post 1 content', CommentsCounter: 1, LikesCounter: 1)
  end

  let!(:comments) do
    [
      Comment.create(post: post1, author: user1, Text: 'Hi Tom c1!'),
      Comment.create(post: post1, author: user1, Text: 'Hi Tom c2!'),
      Comment.create(post: post1, author: user1, Text: 'Hi Tom c3!')

    ]
  end

  describe 'user content and respective posts for that user' do
    before(:example) do
      visit user_post_path(user1, post1)
    end

    it 'shows posts title' do
      expect(page).to have_content(post1.Title)
    end
    it 'shows posts author of the post' do
      expect(page).to have_content(user1.Name)
    end

    it 'Can see the post body' do
      expect(page).to have_content(post1.Text)
    end

    it 'shows posts comments and likes' do
      expect(page).to have_content("Comments: #{post1.CommentsCounter}")
      expect(page).to have_content("Likes: #{post1.LikesCounter}")
    end
    it 'shows posts commenters or authors of comments' do
      expect(page).to have_content(comments[0].author.Name)
      expect(page).to have_content(comments[1].author.Name)
      expect(page).to have_content(comments[2].author.Name)
    end
    it 'shows posts comments' do
      expect(page).to have_content(comments[0].Text)
      expect(page).to have_content(comments[1].Text)
      expect(page).to have_content(comments[2].Text)
    end
  end
end