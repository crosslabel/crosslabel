require 'rails_helper'

RSpec.describe "Admin Panel", :type => :feature do
  scenario "accesses the dashboard" do
    user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    Profile.create!(user_id: user.id, username: 'exampleuser')

    visit root_path
    click_link "Log in"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: "password"
    click_button "Log in"

    visit admin_dashboard_path

    expect(current_path).to eq(admin_dashboard_path)
    within 'h1' do
      page.should have_content 'Administration'
    end
    page.should have_content 'Manage Users'
    page.should have_content 'Manage Products'
  end
end
