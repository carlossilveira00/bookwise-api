require 'rails_helper'

RSpec.describe UserLibrariesController, type: :controller do
  describe "GET /index" do
    describe 'GET /index' do
      it 'returns 200 status code.' do
        get :index

        expect(response).to have_http_status(:ok)
      end

      xit 'returns response in json.' do
        get :index

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      xit 'returns all the books in the DB.' do
        get :index

        expect(response.body).to eq(Book.all.to_json)
      end
    end
  end
end
