require 'rails_helper'
feature "Logging in with Facebook connect" do
  before do
    visit root_path
    set_omniauth()
    click_link_or_button 'Log in with Facebook'
  end
  scenario "should render home page" do
    expect(page).to have_content('Discover')
  end
end
