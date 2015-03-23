class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include Authorizable

  def logged_in_user
    unless current_user
      flash[:notice] = "Please log in."
      redirect_to root_path
    end
  end
end
