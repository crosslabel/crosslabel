require 'rails_helper'

feature 'User signing in with email' do
  let(:user) { FactoryGirl.create(:user)}
  scenario "they see index page" do
    visit root_path
    within('.login-form-wrapper') do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button 'Log me in!'
    end

    expect(page).to_not have_content('Discover')
  end
end
