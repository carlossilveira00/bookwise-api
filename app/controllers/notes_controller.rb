class NotesController < ApplicationController
  def index
    @notes = Note.where('user_id == ?', params[:id])

    render json: NoteBlueprint.render(@notes)
  end

  def show
    @note = Note.find(params[:id])

    render json: @note
  end
end
