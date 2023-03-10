class NotesController < ApplicationController
  def index
    @notes = Note.where('user_id == ?', params[:id])

    render json: NoteBlueprint.render(@notes)
  end

  def book_notes
    @notes = Note.where('user_library_id == ?', params[:user_book_id])

    render json: NoteBlueprint.render(@notes)
  end

  def show
    @note = Note.find(params[:id])

    render json: NoteBlueprint.render(@note)
  end

  def create
    @note = Note.new({ user_library_id: params[:user_book_id], user_id: params[:user_id] })
    @note.title = 'Enter your notes here.'
    @note.body = 'What are your thoughts on this book?'

    if @note.save
      render json: NoteBlueprint.render(@note)
    else
      render json: {
        message: 'Could not create note.',
        status: :unauthorized
      }
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params)
      render json: NoteBlueprint.render(@note)
    else
      render json: {
        message: 'Could not update note.',
        status: :unauthorized
      }
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.destroy
      render json: {
        message: 'This note was deleted from your library.'
      }, status: :ok
    else
      render json: {
        message: 'Could delete this note from your library.',
        status: :unauthorized
      }
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :user_library_id, :title, :body, :tag)
  end
end
