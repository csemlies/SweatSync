class PlanSessionsController < ApplicationController
  def new
    @plan_session = PlanSession.new
  end

  def create
    @plan_session = PlanSession.new(plan_session_params)

    creator = User.first # MVP placeholder
    @plan_session.created_by_user_id = creator.id if @plan_session.respond_to?(:created_by_user_id=)

    if @plan_session.save
      SessionMember.create!(plan_session: @plan_session, user: creator)
      InviteLink.create!(plan_session: @plan_session, token: SecureRandom.alphanumeric(8).upcase)

      redirect_to plan_session_path(@plan_session), notice: "Session created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @plan_session = PlanSession.find(params[:id])
    @invite_link = InviteLink.find_by!(plan_session_id: @plan_session.id)
  end

  private

  def plan_session_params
    params.require(:plan_session).permit(:name, :window_type, :start_date, :end_date)
  end
end
