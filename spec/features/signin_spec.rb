require 'rails_helper'

feature 'User signing in with email' do
  let(:user) { FactoryGirl.create(:user)}
  scenario "redirects to explore page" do
    visit new_user_session_path
    within('.new_user') do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button 'Log me in!'
    end

    current_path.should == explore_path
  end

end
