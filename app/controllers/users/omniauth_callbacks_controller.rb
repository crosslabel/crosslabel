class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = env['omniauth.auth']
    authentication = Authentication.find_with_omniauth(auth)

    if authentication.nil?
      authentication = Authentication.create_with_omniauth(auth)
    end

    if signed_in?
      if authentication.user == current_user
        redirect_to root_path, notice: "You have already linked this account"
      else
        authentication.user = current_user
        authentication.save
        redirect_to root_path, notice: "Account successfully authenticated"
      end
    else
      if authentication.user.present?
        sign_in authentication.user
        if authentication.user.activated?
          redirect_to root_path, notice: "Welcome back, #{authentication.user.name}!"
        else
          redirect_to after_omniauth_path(:add_username)
        end
      else
        user = User.create_with_omniauth(auth)
        user.authentications << authentication
        sign_in user
        redirect_to after_omniauth_path(:add_username)
      end
      Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: "Logged In", properties: {})
    end
    # if user.persisted?
    #   sign_in user
    #   if user.activated?
    #     Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: "Logged In", properties: {})
    #     redirect_to root_path
    #   else
    #     redirect_to after_omniauth_path(:add_username)
    #   end
    # end
      # sign_in user
      # Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: "Logged In", properties: {})
      # flash[:notice] = t('devise.omniauth_callbacks.success', :kind => User::SOCIALS[params[:action].to_sym])
      # if user.sign_in_count == 1
      #   redirect_to after_sign_in_path_for(user)
      # else
      #   redirect_to root_path
      # end
    # else
    #   session['devise.user_attributes'] = user.attributes
    #   redirect_to new_user_registration_url
    # end
  end

  User::SOCIALS.each do |k, _|
    alias_method k, :all
  end

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || explore_path
  end


end
