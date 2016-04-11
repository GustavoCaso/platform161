class PasswordsController < ApplicationController
  def new
    @password_form = PasswordForm.new(current_user)
  end

  def create
    @password_form = PasswordForm.new(current_user)
    if @password_form.submit(params[:password_form])
      flash[:success] = 'You have updated your Password'
      redirect_to current_user, success: "Successfully changed password."
    else
      render "new"
    end
  end
end
