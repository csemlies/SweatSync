class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def after_sign_in_path_for(resource_or_scope)
    # If user was trying to join a session, send them back to the join flow
    if session[:join_token].present?
      token = session.delete(:join_token)
      return join_path(token: token)
    end

    session.delete(:after_auth_redirect) || super
  end

  def after_sign_up_path_for(resource_or_scope)
    if session[:join_token].present?
      token = session.delete(:join_token)
      return join_path(token: token)
    end

    session.delete(:after_auth_redirect) || super
  end
end
