class ProfilesController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
  end

  def edit
    @profile = Profile.find_by(user_id: current_user)
  end

  def update
    @user = User.find_by_username(params[:username])
    @profile = Profile.find_by(user_id: current_user)
    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :country, :birth_date, :profile_image)
  end
end
