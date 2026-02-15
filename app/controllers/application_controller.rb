class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user

  private

  def set_current_user
    # prefer session (signed-in user), but allow user_id via params when you redirect links
    @current_user = User.find_by(id: session[:user_id]) || User.find_by(id: params[:user_id])
  end

  def current_user
    @current_user
  end
end
