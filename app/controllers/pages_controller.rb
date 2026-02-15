class PagesController < ApplicationController
  # allow unauthenticated visitors to see the homepage
  skip_before_action :authenticate_user!, only: [:home]

  def home
    today = Date.current
    sessions = PlanSession.order(created_at: :desc)

    @active_sessions, @past_sessions =
      sessions.partition { |s| s.end_date.present? && s.end_date >= today }
  end
end
