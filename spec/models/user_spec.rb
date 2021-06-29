require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user_params={
      first_name: 'Sophia',
      last_name: 'Liu',
      email: 'sophialiu@example.com',
      password: '123456',
      password_confirmation: '123456'
    }
    
  end

  context "validation specs" do
    it" should have password" do
      @user_params[:password]=""
      @user = User.create @user_params
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages.first).to eq("Password can't be blank")     
    end

    it" password and password_confirmation should match " do
      @user_params[:password_confirmation]="12345"
      @user = User.create @user_params
      expect(@user).not_to be_valid   
      expect(@user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")    
    end

    it "email should be unique and not case sensitive" do
      @user = User.create @user_params
      @user_params[:email]="Sophialiu@example.com"
      @user = User.create @user_params
      expect(@user).not_to be_valid   
      expect(@user.errors.full_messages.first).to eq("Email has already been taken")    
    end
   
    it "email should be required" do
      @user_params[:email]=""
      @user = User.create @user_params
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages.first).to eq("Email can't be blank")     
    end

    it "first_name should be required" do
      @user_params[:first_name]=""
      @user = User.create @user_params
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages.first).to eq("First name can't be blank")    
    end

    it "last_name should be required" do
      @user_params[:last_name]=""
      @user = User.create @user_params
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages.first).to eq("Last name can't be blank")   
    end

  end
end
