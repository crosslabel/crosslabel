class Users::SessionsController < Devise::SessionsController
  def new
    render :layout => "transparent_header"
  end
end
