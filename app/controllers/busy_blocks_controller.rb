class BusyBlocksController < ApplicationController
  def new
    @plan_session = PlanSession.find(params[:plan_session_id])
    @user = User.find(params[:user_id])

    # Use the session start_date to decide which week to show (Mon–Sun)
    session_start = @plan_session.start_date.to_date
    @week_start = session_start.beginning_of_week(:monday)
    @week_days = (0..6).map { |i| @week_start + i.days }

    @busy_blocks = BusyBlock.where(plan_session: @plan_session, user: @user).order(:start_dt)
  end

  def create
    plan_session = PlanSession.find(params[:plan_session_id])
    user = User.find(params[:user_id])

    BusyBlock.create!(
      plan_session: plan_session,
      user: user,
      start_dt: params[:busy_block][:start_dt],
      end_dt: params[:busy_block][:end_dt]
    )

    redirect_to new_busy_block_path(plan_session_id: plan_session.id, user_id: user.id),
                notice: "Saved! Click more slots to add more busy times."
  end
end
