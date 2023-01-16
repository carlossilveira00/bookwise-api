require 'rails_helper'

RSpec.describe UserLibrariesController, type: :controller do
    describe 'GET /index' do
      it 'returns 200 status code.' do
        get :index, params: { id: 1 }

        expect(response).to have_http_status(:ok)
      end

      it 'returns response in json.' do
        get :index, params: { id: 1 }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the whole library for a specific user.' do
        get :index, params: { id: 1 }

        expect(response.body).to eq(UserLibrary.where('user_id == ?', 1).to_json)
      end
    end
end
