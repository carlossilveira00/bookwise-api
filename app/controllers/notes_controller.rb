class NotesController < ApplicationController
  def index
    @notes = Note.where('user_id == ?', params[:id])

    render json: @notes
  end
end
