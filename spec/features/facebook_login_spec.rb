require 'rails_helper'
feature "Signing up with Facebook connect" do
  before do
    visit new_user_registration_path
    set_omniauth
    click_link_or_button 'Sign up with Facebook'
    fill_in "user_username", with: "Test"
    click_link_or_button 'Finish my registration!'
  end

  scenario "redirects to explore path" do
    expect(current_url).to eq(root_url)
  end
end
