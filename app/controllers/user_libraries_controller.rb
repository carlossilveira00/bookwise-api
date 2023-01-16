class UserLibrariesController < ApplicationController
  def index
    @library = UserLibrary.where('user_id == ?', params[:id])

    render json: UserLibraryBlueprint.render(@library)
  end

  def create
    @book_association = UserLibrary.new(user_library_params)

    if @book_association.save
      render json: UserLibraryBlueprint.render(@book_association)
    else
      render json: {
        message: 'Could not add this book to your library.',
        status: :unauthorized
      }
    end
  end

  private

  def user_library_params
    params.require(:book_association).permit(:book_id, :user_id, :status, :start_date, :end_date)
  end
end
