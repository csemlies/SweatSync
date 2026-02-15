class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])        # add :avatar_url only if you want it
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
