class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(env['omniauth.auth'], current_user)
    if user.persisted?
      sign_in user
      flash[:notice] = t('devise.omniauth_callbacks.success', :kind => User::SOCIALS[params[:action].to_sym])
      if user.sign_in_count == 1
        redirect_to after_sign_in_path_for(user)
      else
        redirect_to root_path
      end
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end

  end

  User::SOCIALS.each do |k, _|
    alias_method k, :all
  end

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || explore_path
  end


end
