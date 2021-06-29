require 'rails_helper'
require 'support/database_cleaner'

RSpec.feature "UserLogins", type: :feature, js:true do

  before :each do
    # create a user
    @user=User.create!(
      first_name: 'Sophia',
      last_name: 'Liu',
      email: 'sophialiu@example.com',
      password: '123456',
      password_confirmation: '123456'
    )  

  end

  scenario "user can login" do

    # ACT
     visit new_session_path
     fill_in "email", with: @user.email
     fill_in "password", with: @user.password
     click_button "Submit"

    # DEBUG / VERIFY
    expect(page).to have_text "Logout"
    save_screenshot "user_login.png"
 
  end

end
