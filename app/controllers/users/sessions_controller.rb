class Users::SessionsController < Devise::SessionsController
  def new
    render :layout => "home_index"
  end
end
