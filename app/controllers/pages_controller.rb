# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :auth_gate]

  def home
    # existing home logic
  end

  def auth_gate
    session[:after_auth_redirect] = params[:redirect_to] if params[:redirect_to].present?
  end
end
