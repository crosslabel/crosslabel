class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  def activated_only
    if current_user
        flash[:notice] = "Please complete your profile."
        redirect_to after_omniauth_path(:add_username) unless current_user.activated?
    end
  end

  def logged_in_user
    unless current_user
      flash[:notice] = "Please log in."
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || explore_path
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
