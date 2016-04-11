class SessionsController < ApplicationController
  def new;end

  def create
    user = User.find_by(email: params[:session][:email].upcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Welcome back #{user.user_name}"
      redirect_to user
    else
      flash[:danger] = 'There were some errors with the information provide'
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = 'Succesfully Logout. See you soon :)'
    redirect_to root_path
  end
end
