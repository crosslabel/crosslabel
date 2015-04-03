class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
    @user = User.find_by(username: params[:username])
  end

  def update
    @user = User.find_by_username(params[:username])
    if @user.update(user_params)
      redirect_to @user
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
    redirect_to user_path @user.username
  end

  def remove_avatar
    current_user.remove_profile_photo
    respond_to do |format|
      format.html { redirect_to user_path(current_user.username) }
      format.json { render :json => current_user }
    end
  end

  def set_default_facebook_photo # Figure out how to access Facebook photo through ajax
    current_user.set_default_facebook_photo
    respond_to do |format|
      format.html { redirect_to user_path(current_user.username) }
      format.json { render :json => current_user.authentications.find_by(provider: "facebook") }
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :avatar)
  end
end
