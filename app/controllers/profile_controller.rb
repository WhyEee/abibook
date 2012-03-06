class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @student = current_user.student
  end

  def update
    @student = current_user.student

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to root_path, notice: 'Dein Steckbrief wurde erfolgreich gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end
end
