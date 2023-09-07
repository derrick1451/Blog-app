require 'rails_helper'
RSpec.describe '/users', type: :request do
  describe 'GET /index' do
    it 'it returns a successfull response' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get '/users'
      expect(response).to render_template('users/index')
    end
    it 'the response body includes correct placeholder text.' do
      get '/users'
      expect(response.body).to include('Lists all users')
    end
  end

  describe 'GET / show' do
    it 'it return a successfull response' do
      get '/users/:id'
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      get '/users/:id'
      expect(response).to render_template('users/show')
    end
    it 'the response body includes correct placeholder text.' do
      get '/users/:id'
      expect(response.body).to include('Lists a user depending on the id')
    end
  end
end
