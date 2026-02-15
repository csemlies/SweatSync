class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) || User.find_by(id: params[:user_id])
  end

  def current_user
    @current_user
  end

  protected

  def configure_permitted_parameters
    # sign_up params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # account update params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
