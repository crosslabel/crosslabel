require 'rails_helper'
feature "Signing up with Facebook connect" do
  before do
    visit new_user_registration_path
    set_omniauth
    click_link_or_button 'Sign up with Facebook'
  end

  scenario "should render home page" do
    expect(page).to have_content("Beyond the boundaries")
  end
end
