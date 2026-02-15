class ApplicationController < ActionController::Base
  skip_forgery_protection

  # require login by default
  before_action :authenticate_user!

  # allow additional Devise params
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar_url])
  end

  # optional: redirect after login
  def after_sign_in_path_for(resource)
    plan_sessions_path # or profile_path if you prefer
  end
end
