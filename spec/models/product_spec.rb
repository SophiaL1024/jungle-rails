require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validate products' do

    before(:each) do
      cat1 = Category.create name: 'Apparel'
      @product=cat1.products.create({
        name:  'Men\'s Classy shirt',
        quantity: 10,
        price_cents: 6499
      })
    end
   # test the product is valid with all four fields set
    it "product should be validate" do
      expect(@product).to be_valid
    end

    # test the product is invalid, when name is nil
    it "product should not be validate, when name is nil" do
      @product.name=nil
      expect(@product).not_to be_valid      
      expect(@product.errors.full_messages.first).to eq "Name can't be blank"
    end

    # test the product is invalid, when name is nil
    it "product should not be validate, when price is nil" do
      @product.price_cents=nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.first).to eq "Price cents is not a number"
    end

    # test the product is invalid, when name is nil
    it "product should not be validate, when quantity is nil" do
      @product.quantity=nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    # test the product is invalid, when name is nil
    it "product should not be validate, when category is nil" do
      @product.category=nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages.first).to eq "Category can't be blank"
    end 

  end
end
