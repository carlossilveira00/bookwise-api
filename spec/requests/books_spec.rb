require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET /index' do
    it 'returns 200 status code.' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns body response in json.' do
      get :index
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns all the books in the DB.' do
      get :index
      expect(response.body).to eq(Book.all.to_json)
    end
  end
end
