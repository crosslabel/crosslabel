class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      redirect_to after_sign_in_path_for(@user)
      flash[:success] = "Welcome back, #{@user.username}"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:notice] = "Please register an account"
      redirect_to new_user_registration_url
    end
  end

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || explore_path
  end


end
