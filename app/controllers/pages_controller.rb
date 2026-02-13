class PagesController < ApplicationController
  def home
  today = Date.current

  @active_sessions = PlanSession.where("end_date >= ?", today)
                                 .order(:start_date)

  @past_sessions = PlanSession.where("end_date < ?", today)
                               .order(start_date: :desc)
end

    today = Date.current
    @active_sessions = @sessions.select do |s|
      s.start_date && s.end_date && (s.start_date..s.end_date).cover?(today)
    end
  end
end
