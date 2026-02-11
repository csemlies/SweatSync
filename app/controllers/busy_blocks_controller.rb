class BusyBlocksController < ApplicationController
  def new
    @plan_session = PlanSession.find(params[:plan_session_id])
    @user = User.find(params[:user_id])
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

    # send them back so they can add more
    redirect_to new_busy_block_path(plan_session_id: plan_session.id, user_id: user.id),
                notice: "Saved! Add another busy time (or go back to the session)."
  end
end
