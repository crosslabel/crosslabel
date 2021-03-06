class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    if resource.activated?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      respond_with resource, location: after_omniauth_path(:add_username)
    end
  end

  def destroy
    super
  end

  def after_sign_in_path_for(resource)
    explore_path
  end
end
