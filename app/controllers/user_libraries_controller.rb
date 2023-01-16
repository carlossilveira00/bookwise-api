class UserLibrariesController < ApplicationController
  def index
    @library = UserLibrary.where('user_id == ?', params[:id])

    render json: UserLibraryBlueprint.render(@library)
  end
end
