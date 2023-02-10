class UserLibrariesController < ApplicationController
  before_action :auth_user, only: [:create, :update, :destroy]

  def index
    @library = UserLibrary.where('user_id == ?', params[:id])

    render json: UserLibraryBlueprint.render(@library)
  end

  def create
    @user_book = UserLibrary.new(user_library_params)
    @user_book.status = 'Wishlist'
    @user_book.started_date = Time.now

    if @user_book.save
      render json: UserLibraryBlueprint.render(@user_book)
    else
      render json: {
        message: 'Could not add this book to your library.',
        status: :unauthorized
      }
    end
  end

  def update_status
    @user_book = UserLibrary.find(params[:id])

    # Check to wich status the user wants to update his book.
    case params[:status]
    when 'In Progress' # If he update to the status 'In Progress' it's because he started the book
      # We change the status of the user book and set the started date to Time.now to give
      # the current date.
      started_book(@user_book)
    when 'Completed' # If he update to the status 'Completed' it's because he finished the book
      # We change the status of the user book and set the ended date to Time.now to give
      # the current date.
      finished_book(@user_book)
    else # The other option its refering to the status of 'Wishlist. We update the status and set the dates to nil.
      @user_book.update(status: 'Wishlist', started_date: nil, ended_date: nil)
    end

    # Save the user book instance
    if @user_book.save
      render json: UserLibraryBlueprint.render(@user_book)
    else
      render json: {
        message: 'Could not update the status of your book.',
        status: :unauthorized
      }
    end
  end

  def destroy
    @user_book = UserLibrary.find(params[:id])

    if @user_book.destroy
      render json: {
        message: 'This book was deleted from your library.'
      }, status: :ok
    else
      render json: {
        message: 'Could delete this book from your library.',
        status: :unauthorized
      }
    end
  end

  private
  def auth_user
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])
  end

  def user_library_params
    params.require(:book_association).permit(:book_id, :user_id)
  end

  def started_book(user_book)
    user_book.update(status: 'In Progress', started_date: Time.now)
  end

  def finished_book(user_book)
    user_book.update(status: 'Completed', ended_date: Time.now)
  end
end
