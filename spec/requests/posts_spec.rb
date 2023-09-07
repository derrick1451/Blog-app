require 'rails_helper'
RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    it 'it returns a successfull response' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get '/users/:user_id/posts'
      expect(response).to render_template('posts/index')
    end
    it 'the response body includes correct placeholder text.' do
      get '/users/:user_id/posts'
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
  describe 'GET / show' do
    it 'it returns a successfull response' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template('posts/show')
    end
    it 'the response body includes correct placeholder text.' do
      get '/users/:user_id/posts/:id'
      expect(response.body).to include('Here is a post for a given id')
    end
  end
end
