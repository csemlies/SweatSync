class BusyBlocksController < ApplicationController
  def new
    @plan_session = PlanSession.find(params[:plan_session_id])
    @user = User.find(params[:user_id]) # MVP placeholder

    @busy_blocks = BusyBlock.where(plan_session: @plan_session, user: @user).order(:start_dt)

    # Build the week grid (Mon–Sun of the week containing the session start)
    week_start = @plan_session.start_date.beginning_of_week(:monday)
    @days = (0..6).map { |i| week_start + i.days }

    # Times down the left side (30-min slots). Adjust hours if you want.
    start_hour = 6
    end_hour = 22
    @times = []
    t = Time.zone.local(2000, 1, 1, start_hour, 0)
    while t.hour < end_hour
      @times << t
      t += 30.minutes
    end
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

    redirect_to new_plan_session_busy_block_path(plan_session, user_id: user.id),
                notice: "Busy times saved!"
  end

  def destroy
    plan_session = PlanSession.find(params[:plan_session_id])
    block = BusyBlock.find(params[:id])

    # safety: only delete if it belongs to this session
    unless block.plan_session_id == plan_session.id
      head :unprocessable_entity and return
    end

    block.destroy
    head :no_content
  end
end
