class BooksController < ApplicationController
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
      render json: BookBlueprint.render(@book)
    else
      render json: {
        message: 'Could not create book.',
        status: :unauthorized
      }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :pages, :author, :category, :thumbnail_url, :publisher, :ISBN, :published_date)
  end
end
