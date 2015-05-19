class AfterOmniauthController < ApplicationController
  include Wicked::Wizard

  layout 'devise'

  steps :add_username

  def show
    @user = current_user
    if @user
      case step
      when :add_username
      end
      render_wizard
    end
  end

  def update
    @user = current_user
    case step
    when :add_username
      @user.activated = true
      @user.update(user_params)
    end
    render_wizard @user
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end

end
