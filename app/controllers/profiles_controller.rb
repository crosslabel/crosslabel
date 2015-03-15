class ProfilesController < ApplicationController
  def show
    @user = Profile.find_by_username(params[:username])
  end

  
end
