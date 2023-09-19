require 'rails_helper'
RSpec.describe 'User show Page' do
  it 'should display user information' do
    user = User.create(Name: 'derrick', Photo: 'https://placehold.co/200x133', PostsCounter: 0,
                       Bio: 'I am a software developer')

    visit user_path(user)
    expect(page).to have_content(user.Name)
    expect(page).to have_css("img[src*='#{user.Photo}']")
    expect(page).to have_content("Number of posts: #{user.PostsCounter}")
    expect(page).to have_content(user.Bio)
  end
  it 'Can see the user first 3 posts and Displays a see more button to display all posts' do
    user = User.create(Name: 'derrick', Photo: 'https://placehold.co/200x133', PostsCounter: 0,
                       Bio: 'I am a software developer')
    Post.create(Title: 'Post 1', Text: 'Post 1 content', author: user)
    Post.create(Title: 'Post 2', Text: 'Post 2 content', author: user)
    Post.create(Title: 'Post 3', Text: 'Post 3 content', author: user)

    visit user_path(user)
    expect(page).to have_content('Post 1 content')
    expect(page).to have_content('Post 2 content')
    expect(page).to have_content('Post 3 content')
    expect(page).to have_link('see all posts')
  end
  it "When I click to see all posts, it redirects me to the user's post's index page." do
    user = User.create(Name: 'derrick', Photo: 'https://placehold.co/200x133', PostsCounter: 0,
                       Bio: 'I am a software developer')
    Post.create(Title: 'Post 1', Text: 'Post 1 content', author: user)
    Post.create(Title: 'Post 2', Text: 'Post 2 content', author: user)
    Post.create(Title: 'Post 3', Text: 'Post 3 content', author: user)

    visit user_path(user)
    click_link 'see all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
