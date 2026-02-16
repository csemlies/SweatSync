class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])        # add :avatar_url only if you want it
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  protected

  def after_sign_in_path_for(resource_or_scope)
    session.delete(:after_auth_redirect) || super
  end

  def after_sign_up_path_for(resource_or_scope)
    session.delete(:after_auth_redirect) || super
  end
end
