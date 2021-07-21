class NotesController < ApplicationController
  def destroy
    Note.find(params[:id]).destroy
    render json: { message: "Note destroyed!" }
  end
end
