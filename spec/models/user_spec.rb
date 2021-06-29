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

  describe 'Validations' do
 
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
      @user_params[:email]="Sophialiu@exAmple.com"
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

    it "password'length should be greater than three " do
      @user_params[:password]="12"
      @user_params[:password_confirmation]="12"
      @user = User.create @user_params
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages.first).to eq("Password is too short (minimum is 3 characters)")  
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate email and password and login" do 
      @user_authen = User.authenticate_with_credentials('sophialiu@example.com', '123456')
      expect(@user_authen).equal?(@user)
    end

    it "should not login, if password not match email" do
      @user_authen = User.authenticate_with_credentials('sophialiu@example.com', '12345')
      expect(@user_authen).equal?(nil)
    end
  end

  describe "edge cases" do
    it "should trim spaces before or after email adress, when login " do
      @user_authen = User.authenticate_with_credentials('  sophialiu@example.com   ', '123456')
      expect(@user_authen).equal?(@user)
    end

    it "login email should not be case sensitive" do
      @user_authen = User.authenticate_with_credentials('SophiaLiu@exAmple.com', '123456')
      expect(@user_authen).equal?(@user)

    end
  end

end
