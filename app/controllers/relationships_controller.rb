class RelationshipsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_id])
    if current_user.create_following_relationship(followed_user)
      flash[:success] = "You are following #{followed_user.user_name}"
      redirect_to :back
    else
      flash[:danger] = "There has been some error, please try again later"
    end
  end

  def destroy
    relationship =  Relationship.find(params[:id])
    if relationship.destroy
      flash[:success] = "You no longer follow that user"
      redirect_to :back
    else
      flash[:danger] = "There has been some error, please try again later"
    end
  end
end
