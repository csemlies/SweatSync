class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = params[:id].present? ? User.find(params[:id]) : current_user

    @owned_sessions = @user.plan_sessions.order(start_time: :desc)
  end
end
