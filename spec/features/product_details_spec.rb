require 'rails_helper'
require 'support/database_cleaner'

RSpec.feature "ProductDetails", type: :feature, js:true do
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
  end
  scenario "Can see the clicked product detail" do
    # ACT
    visit root_path
    page.find('article>header', match: :first).click
  
    # DEBUG / VERIFY
    expect(page).to have_text 'Description', count: 1
    expect(page).to have_css '.product-detail', count: 1
    save_screenshot "product_details.png"
  end


end
