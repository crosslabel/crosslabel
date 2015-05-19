class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        resource.update(activated: true)
        if resource.activated?
          Resque.enqueue(WelcomeEmailSender, resource.id)
          respond_with resource, location: after_sign_up_path_for(resource)
        end
        Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: "Signed Up", properties: {})
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

end
