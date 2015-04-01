class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
  end
  def update
    @user = User.find_by_username(params[:username])
    if @user.update(profile_params)
      redirect_to @profile
      flash[:success] = "Your account has been updated."
    else
      flash[:danger] = "Something went wrong."
      render :edit
    end
  end

  def upload_avatar
    @user = User.find_by_username(params[:username])
    file = params[:avatar]
    @user.update_attribute(:avatar, file)
    redirect_to profile_path @user.username
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :avatar)
  end
end
