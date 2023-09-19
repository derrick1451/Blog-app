require 'rails_helper'
RSpec.describe 'Users Index Page' do
  it 'should display user information' do
    user = User.create(Name: 'derrick', Photo: 'https://placehold.co/200x133', PostsCounter: 0)
    user1 = User.create(Name: 'kagiso', Photo: 'https://placehold.co/200x133', PostsCounter: 0)
    user2 = User.create(Name: 'jorry', Photo: 'https://placehold.co/200x133', PostsCounter: 0)
    user3 = User.create(Name: 'fred', Photo: 'https://placehold.co/200x133', PostsCounter: 0)

    visit users_path

    [user, user1, user2, user3].each do |u|
      expect(page).to have_content(u.Name)
      expect(page).to have_css("img[src*='#{u.Photo}']")
      expect(page).to have_content("Number of posts: #{u.PostsCounter}")
    end
  end

  it "should redirect to user's show page when clicked on a user" do
    user = User.create(Name: 'Derrick', Photo: 'https://placehold.co/200x133', PostsCounter: 0)

    visit users_path

    click_link user.Name

    expect(page).to have_current_path(user_path(user))
  end
end
