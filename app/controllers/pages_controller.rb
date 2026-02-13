class PagesController < ApplicationController
  def home
    @user = User.first
    @sessions = if @user
      PlanSession.joins(:session_members)
                 .where(session_members: { user_id: @user.id })
                 .order(created_at: :desc)
    else
      PlanSession.none
    end

    today = Date.current
    @active_sessions = @sessions.select do |s|
      s.start_date && s.end_date && (s.start_date..s.end_date).cover?(today)
    end
  end
end
