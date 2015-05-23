class Users::PasswordsController < Devise::PasswordsController
  layout 'devise'
  def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for)
      else
        respond_with(resource)
      end
    end

  protected
  def after_sending_reset_password_instructions_path_for
    root_path
  end
   def after_resetting_password_path_for(resource)
     login_path
  end
end
