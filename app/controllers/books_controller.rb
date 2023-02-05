class BooksController < ApplicationController
  before_action :auth_user, only: [:create]

  def index
    @books = Book.all

    render json: BookBlueprint.render(@books)
  end

  def show
    @book = Book.find(params[:id])

    render json: BookBlueprint.render(@book)
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: {
        message: 'Book successfully created!',
        status: :ok
      }
    else
      render json: {
        message: 'Could not create this book.',
        status: :unauthorized
      }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :pages, :author, :category, :thumbnail_url, :publisher, :ISBN, :published_date)
  end

  def auth_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])
  end
end
