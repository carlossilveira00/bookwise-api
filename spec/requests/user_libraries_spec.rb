require 'rails_helper'

RSpec.describe UserLibrariesController, type: :controller do
  describe 'GET /index' do
    before(:each) do
      # Create a user
      @user = User.create(email: 'test@example.com', password: 'password')

      sign_in @user
    end

    it 'returns 200 status code.' do
      get :index, params: { id: @user.id }

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json.' do
      get :index, params: { id: @user.id }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the whole library for a specific user.' do
      get :index, params: { id: @user.id }

      expect(response.body).to eq(UserLibrary.where('user_id == ?', 1).to_json)
    end
  end

  describe 'POST /create' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      sign_in @user
    end

    it 'returns a 200 status code.' do
      post :create, params: { book_association: { book_id: @book.id, user_id: @user.id } }

      expect(response).to have_http_status(:ok)
    end

    it 'returns the response in json' do
      post :create, params: { book_association: { book_id: @book.id, user_id: @user.id } }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PATCH /update_status' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_library instance for the user and book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)
    end

    context 'Update status to In Progress' do
      it 'returns a 200 status code.' do
        patch :update_status, params: { id: @user_book.id, status: 'In Progress' }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the response in json' do
        patch :update_status, params: { id: @user_book.id, status: 'In Progress' }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end


      it 'updates the status to In Progress and sets the started_date' do
        patch :update_status, params: { id: @user_book.id, status: 'In Progress' }
        json_response = JSON.parse(response.body)

        expect(json_response['status']).to eq('In Progress')
        expect(json_response['started_date']).not_to be_nil
      end
    end

    context 'Update status to Completed' do
      it 'returns a 200 status code.' do
        patch :update_status, params: { id: @user_book.id, status: 'Completed' }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the response in json' do
        patch :update_status, params: { id: @user_book.id, status: 'Completed' }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end


      it 'updates the status to Completed and sets the ended_date' do
        patch :update_status, params: { id: @user_book.id, status: 'Completed' }
        json_response = JSON.parse(response.body)

        expect(json_response['status']).to eq('Completed')
        expect(json_response['ended_date']).not_to be_nil
      end
    end

    context 'Update Status to Wishlist' do
      it 'returns a 200 status code' do
        patch :update_status, params: { id: @user_book.id, status: 'Wishlist' }
        expect(response).to have_http_status(:ok)
      end

      it 'return the response in json' do
        patch :update_status, params: { id: @user_book.id, status: 'Wishlist' }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'updates the status to Wishlist and set the ended_date and started_date to nil' do
        patch :update_status, params: { id: @user_book.id, status: 'Wishlist' }
        json_response = JSON.parse(response.body)

        expect(json_response['status']).to eq('Wishlist')
        expect(json_response['started_date']).to be_nil
        expect(json_response['ended_date']).to be_nil
      end
    end
  end

  describe 'DELETE /destroy' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_library instance for the user and book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      sign_in @user
    end

    context 'Deletes the user_library instance' do
      it 'returns a 200 status code.' do
        delete :destroy, params: { id: @user_book.id }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the response in json' do
        delete :destroy, params: { id: @user_book.id }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

end
