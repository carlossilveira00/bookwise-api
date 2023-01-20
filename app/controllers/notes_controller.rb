class NotesController < ApplicationController
  def index
    @notes = Note.where('user_id == ?', params[:id])

    render json: NoteBlueprint.render(@notes)
  end

  def show
    @note = Note.find(params[:id])

    render json: NoteBlueprint.render(@note)
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      render json: NoteBlueprint.render(@note)
    else
      render json: {
        message: 'Could not create note.',
        status: :unauthorized
      }
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :user_library_id, :title, :body, :tag)
  end
end
