class BooksController < ApplicationController
  def index
    @books = Book.all

    render json: @books
  end

  def show
    @book = Book.find(params[:id])

    render json: @book
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book
    else
      render :unauthorized
    end
  end

  private

  def book_params
    params.require(:book).permit(:tittle, :description, :pages, :author, :category, :thumbnail_url, :publisher, :ISBN, :published_date)
  end
end
