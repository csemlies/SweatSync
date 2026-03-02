require "ostruct"

class PlanSessionsController < ApplicationController
  def new
    @plan_session = PlanSession.new
  end

  def create
    # Require a signed-in user (Devise)
    creator = current_user
    unless creator
      return redirect_to new_user_session_path, alert: "Please sign in to create a session."
    end

    @plan_session = PlanSession.find_or_create_by!(
      created_by_user_id: creator.id,
      title: plan_session_params[:title],
      start_date: plan_session_params[:start_date],
      end_date: plan_session_params[:end_date],
    ) do |s|
      s.window_type = plan_session_params[:window_type]
    end

    # Ensure the creator is a member
    SessionMember.find_or_create_by!(plan_session: @plan_session, user: creator)

    # Ensure invite exists
    InviteLink.find_or_create_by!(plan_session: @plan_session) do |inv|
      inv.token = SecureRandom.alphanumeric(8).upcase
    end

    redirect_to new_plan_session_busy_block_path(@plan_session, user_id: creator.id),
                notice: "Session ready!"
  end

  def show
    @plan_session = PlanSession.find(params[:id])
    @invite_link = InviteLink.find_by!(plan_session_id: @plan_session.id)
    @join_url = join_url(token: @invite_link.token)

    @members = User.joins(:session_members)
                   .where(session_members: { plan_session_id: @plan_session.id })

    @creator = User.find_by(id: @plan_session.created_by_user_id)
    @current_user = current_user
  end

  def recommendations
    @plan_session = PlanSession.find(params[:id])

    @current_user = current_user

    @members = User.joins(:session_members)
                   .where(session_members: { plan_session_id: @plan_session.id })

    studio = Studio.find_by!(name: "West Loop")

    # template classes = your seeded week (Feb 16–22)
    template = StudioClass.where(studio_id: studio.id).order(:start_dt)

    # build "virtual" classes for the session window by matching weekday + time
    @classes = []
    (@plan_session.start_date..@plan_session.end_date).each do |date|
      template_for_day = template.select { |c| c.start_dt.wday == date.wday }

      template_for_day.each do |c|
        dur = (c.end_dt - c.start_dt).to_i
        start_dt = Time.zone.local(date.year, date.month, date.day, c.start_dt.hour, c.start_dt.min)
        end_dt = start_dt + dur

        @classes << OpenStruct.new(
          id: "tmpl-#{c.id}-#{date}",
          class_name: c.class_name,
          instructor: c.instructor,
          start_dt: start_dt,
          end_dt: end_dt,
        )
      end
    end

    @classes.sort_by!(&:start_dt)

    busy_blocks = BusyBlock.where(plan_session_id: @plan_session.id, user_id: @members.pluck(:id))
    busy_by_user = busy_blocks.group_by(&:user_id)

    @ranked = @classes.map do |klass|
      available_users = @members.select do |u|
        blocks = busy_by_user[u.id] || []
        blocks.none? { |b| b.start_dt < klass.end_dt && b.end_dt > klass.start_dt }
      end

      {
        studio_class: klass,
        available_count: available_users.length,
        available_users: available_users,
      }
    end

    @ranked.sort_by! { |row| [-row[:available_count], row[:studio_class].start_dt] }
    @top3 = @ranked.first(3)
  end

  def join
    token = params[:token].to_s.strip

    # If no token, show paste form
    if token.blank?
      return render :join
    end

    # Find invite link by token
    @invite_link = InviteLink.find_by(token: token)
    unless @invite_link
      flash.now[:alert] = "Invalid or expired invite token."
      return render :join
    end

    @plan_session = @invite_link.plan_session

    # If no signed-in user, stash token and redirect to auth gate / sign-in
    unless current_user
      session[:join_token] = token
      flash[:notice] = "Please sign in to join this session."
      return redirect_to auth_gate_path(redirect_to: join_path(token: token))
    end

    # Signed in: add current_user as member
    SessionMember.find_or_create_by!(plan_session: @plan_session, user: current_user)

    # Send them to add busy times
    redirect_to new_plan_session_busy_block_path(@plan_session, user_id: current_user.id),
                notice: "Joined! Add your busy times."
  end

  # POST /join_lookup
  def lookup
    input = params[:join_input].to_s.strip

    token =
      input[/token=([^&]+)/, 1] || # from URL query param
      input[/\A[A-Za-z0-9]+\z/]     # raw token

    unless token
      flash[:alert] = "Paste the full invite link or the token."
      return redirect_to join_path
    end

    redirect_to join_path(token: token)
  end

  private

  def plan_session_params
    params.require(:plan_session).permit(:title, :window_type, :start_date, :end_date)
  end
end
