class BusyBlocksController < ApplicationController
  def new
    @plan_session = PlanSession.find(params[:plan_session_id])
    @user = User.find(params[:user_id])

    @busy_blocks = BusyBlock.where(plan_session: @plan_session, user: @user).order(:start_dt)

    # Always show a Mon–Sun week that contains the session start_date
    week_start = @plan_session.start_date.beginning_of_week(:monday)
    @days = (0..6).map { |i| week_start + i.days }

    # Time rows (6:00 AM -> 9:30 PM in 30-min steps)
    day = Time.zone.local(week_start.year, week_start.month, week_start.day)
    start_time = day + 6.hours
    end_time   = day + 22.hours # 10:00 PM (last slot starts 9:30)

    @times = []
    t = start_time
    while t < end_time
      @times << t
      t += 30.minutes
      end
    end
  end

  def bulk_create
    plan_session = PlanSession.find(params[:plan_session_id])
    user = User.find(params[:user_id])

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

    unless block.plan_session_id == plan_session.id
      head :unprocessable_entity and return
    end

    block.destroy
    head :no_content
  end
end
