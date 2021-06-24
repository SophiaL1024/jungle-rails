class UsersController < ApplicationController
  def new
  end

  def create

    if user_params[:password]==user_params[:password_confirmation]
      user = User.new(user_params)
        if user.save
           session[:user_id] = user.id
           redirect_to root_path
        else
          redirect_to new_user_path, alert: user.errors.full_messages.first 
        end
    else
        redirect_to new_user_path, alert:"password do not match." 
    end
 
  end  

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,:password_confirmation)
  end

end
