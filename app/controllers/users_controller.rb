class UsersController < ApplicationController
  def index
    @users = User.all.includes(:messages)
  end

  def show
    @user = User.includes(:messages).find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Platform161 social network :)"
      redirect_to @user
    else
      render :new
    end
  end

  def following
    user = User.find(params[:id])
    @users = user.following
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'You have deleted your account, sorry to see you leave'
    redirect_to root
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
      :password_confirmation)
  end
end
