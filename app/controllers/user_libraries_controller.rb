class UserLibrariesController < ApplicationController
  def index
    @library = UserLibrary.where('user_id == ?', params[:id])

    render json: @library
  end
end
