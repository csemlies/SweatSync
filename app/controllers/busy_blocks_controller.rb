class BusyBlocksController < ApplicationController
  def index
    @plan_session = PlanSession.find(params[:plan_session_id])

    # MVP placeholder: however you're getting the current user
    @user = User.find(params[:user_id]) # OR session[:user_id], etc.

    @busy_blocks = BusyBlock.where(plan_session: @plan_session, user: @user).order(:start_dt)
  end

  def bulk_create
    plan_session = PlanSession.find(params[:plan_session_id])
    user = User.find(params[:user_id]) # MVP placeholder

    starts = JSON.parse(params[:starts].presence || "[]")
    duration_min = params[:duration_min].to_i

    starts.each do |start_iso|
      start_dt = Time.iso8601(start_iso)
      end_dt = start_dt + duration_min.minutes

      BusyBlock.create!(
        plan_session: plan_session,
        user: user,
        start_dt: start_dt,
        end_dt: end_dt
      )
    end

    redirect_to plan_session_busy_blocks_path(plan_session, user_id: user.id), notice: "Busy times saved!"
  end
end
