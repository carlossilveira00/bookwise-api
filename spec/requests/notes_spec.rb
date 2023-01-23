require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe 'GET /index' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      # Create a note
      @note = Note.create(user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World')
    end

    it 'returns 200 status code.' do
      get :index, params: { id: @user.id }

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json.' do
      get :index, params: { id: @user.id }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'should include the note create' do
      get :index, params: { id: @user.id }

      expect(response.body).to include(NoteBlueprint.render(@note))
    end
  end

  describe 'GET /show' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      # Create a note
      @note = Note.create(user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World')
    end

    it 'returns a 200 status code' do
      get :show, params: { id: @note.id }

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json' do
      get :show, params: { id: @note.id }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the correct note' do
      get :show, params: { id: @note.id }

      expect(response.body).to eq(NoteBlueprint.render(@note))
    end
  end

  describe 'POST /create' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      # Sign in the user before every action request.
      sign_in @user
    end

    it 'returns 200 status code.' do
      post :create, params: { note: { user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World' } }

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json.' do
      post :create, params: { note: { user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World' } }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST /update' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      # Create a note
      @note = Note.create(user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World')

      # Sign in the user before every action request.
      sign_in @user
    end

    context 'Deletes the note instance' do
      it 'returns a 200 status code.' do
        post :update, params: { id: @note.id, note: { title: 'Updated note', body: 'Hello Earth' } }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the response in json' do
        post :update, params: { id: @note.id, note: { title: 'Updated note', body: 'Hello Earth' } }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'Updates note title' do
        post :update, params: { id: @note.id, note: { title: 'Updated note', body: 'Hello Earth' } }
        json_response = JSON.parse(response.body)

        expect(json_response['title']).to eq('Updated note')
      end

      it 'Updates note title' do
        post :update, params: { id: @note.id, note: { title: 'Updated note', body: 'Hello Earth' } }
        json_response = JSON.parse(response.body)

        expect(json_response['body']).to eq('Hello Earth')
      end
    end
  end

  describe 'DELETE /destroy' do
    before(:each) do
      # Create a user and a book
      @user = User.create(email: 'test@example.com', password: 'password')
      @book = Book.create(title: 'Test Book', description:'Hello World.', author: 'Test Author', category: 'Fiction', ISBN:'HELLOWORLD00')

      # Create a user_book
      @user_book = UserLibrary.create(user_id: @user.id, book_id: @book.id)

      # Create a note
      @note = Note.create(user_id: @user.id, user_library_id: @user_book.id, title: 'First Note', body: 'Hello World')

      # Sign in the user before every action request.
      sign_in @user
    end

    context 'Deletes the note instance' do
      it 'returns a 200 status code.' do
        delete :destroy, params: { id: @note.id }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the response in json' do
        delete :destroy, params: { id: @note.id }

        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

end
