class AfterOmniauthController < ApplicationController
  include Wicked::Wizard

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
      @user.update_attributes(params[:user])
    end
    sign_in(@user, :bypass => true)
    render_wizard @user
  end

end
