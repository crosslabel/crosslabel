class ProfilesController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
  end

  def edit
    @profile = Profile.find_by(user_id: current_user)
  end

  def update
  end

end
