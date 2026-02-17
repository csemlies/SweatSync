class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    owned = @user.plan_sessions

    participating = PlanSession
                      .joins(:session_members)
                      .where(session_members: { user_id: @user.id })
                      .distinct

    all_sessions = (owned.to_a + participating.to_a).uniq

    now = Time.current

    @active_sessions  = all_sessions.select { |s| s.start_time.present? && s.start_time >= now }
                                    .sort_by(&:start_time)
    @expired_sessions = all_sessions.select { |s| s.start_time.blank? || s.start_time < now }
                                    .sort_by(&:start_time).reverse

    @session_roles = {}
    all_sessions.each do |s|
      @session_roles[s.id] = (s.user_id == @user.id ? :host : :member) rescue :member
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
