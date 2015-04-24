
require 'rails_helper'
feature 'User signing up with email' do
  let(:user) { FactoryGirl.create(:user)}
  scenario "redirects to explore page" do
    visit new_user_registration_path
    within('.new_user') do
      fill_in "user_email", with: user.email
      fill_in "user_username", with: user.username
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      click_button 'Sign me up!'
    end

    current_path.should == explore_path
  end
end
