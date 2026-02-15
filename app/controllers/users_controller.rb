class UsersController < ApplicationController
  def show    
    @user = current_user || User.find(session[:user_id]) rescue nil
  end
end
