require 'rails_helper'
require 'support/database_cleaner'

RSpec.feature "AddToCarts", type: :feature, js:true  do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
    # create a user
    @user=User.create!(
      first_name: 'Sophia',
      last_name: 'Liu',
      email: 'sophialiu@example.com',
      password: '123456',
      password_confirmation: '123456'
    )

    # login first
    visit new_session_path
    fill_in "email", with: @user.email
    fill_in "password", with: @user.password
    click_button "Submit"

  end

  scenario "Can add a product to cart" do
    # ACT
    visit root_path
    
    click_button 'Add', match: :first
    
    # DEBUG / VERIFY
    expect(page).to have_text 'My Cart (1)'
    save_screenshot "add_to_cart.png"
 
  end

end
