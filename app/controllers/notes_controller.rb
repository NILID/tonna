class NotesController < ApplicationController
  load_and_authorize_resource except: [:index]

  def index
    @note = Note.new
  end

  def list;  end
  def new;   end

  def create
    respond_to do |format|
      if (user_signed_in? || verify_recaptcha(model: @note)) && @note.save
        format.html { redirect_to root_url, notice: t('note.thanks') }
        format.json { render json: root_url, status: :created, location: @note }
      else
        format.html { render :index }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private
    def note_params
      params.require(:note).permit(:content, :email)
    end
end
