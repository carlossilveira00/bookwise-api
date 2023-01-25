require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET /index' do
    it 'returns 200 status code.' do
      get :index

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json.' do
      get :index

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns all the books in the DB.' do
      get :index

      expect(response.body).to eq(Book.all.to_json)
    end
  end

  describe 'GET /show' do
    before(:each) do
      @book = Book.create({
        title: 'Test book',
        description: 'This book is being created to test the show request',
        author: 'Carlos Silveira',
        category: 'Fiction',
        ISBN: 'KK1129KKDCQ'
      })
    end

    it 'returns 200 status code.' do
      get :show, params: { id: @book.id }

      expect(response).to have_http_status(:ok)
    end

    it 'returns response in json.' do
      get :show, params: { id: @book.id }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the correct book for the id passed' do
      get :show, params: { id: @book.id }

      expect(response.body).to eq(BookBlueprint.render(@book))
    end
  end

  describe 'POST /create' do
    before(:each) do
      @book_hash = {
        title: 'Test book',
        description: 'This book is being created to test the show request',
        pages: 200,
        thumbnail_url: 'www.example.com/thumbnail',
        publisher: 'John Doe Lda',
        published_date: '2022-01-03',
        author: 'Carlos Silveira',
        category: 'Fiction',
        ISBN: 'KK1129KKDCQD'
      }
      @user = User.create(email: 'test@example.com', password: 'password')

      sign_in @user
    end

    it 'returns a 200 status code.' do
      post :create, params: { book: @book_hash }

      expect(response).to have_http_status(:ok)
    end

    it 'returns the response in json' do
      post :create, params: { book: @book_hash }

      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

end
