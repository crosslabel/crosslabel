
require 'rails_helper'
feature 'User signing up with email' do
  let(:user) { FactoryGirl.create(:user)}

  scenario "redirects to explore page" do
    visit new_user_registration_path
    within('.new_user') do
      fill_in "user_email", with: "yepyep@yepyep.com"
      fill_in "user_username", with: "yepyep"
      fill_in "user_password", with: "hellohello"
      fill_in "user_password_confirmation", with: "hellohello"
      click_button 'Sign me up!'
    end

    current_path.should == root_path
  end
end
