require "ostruct"

class PlanSessionsController < ApplicationController
  def new
    @plan_session = PlanSession.new
  end

  def create
    @plan_session = PlanSession.new(plan_session_params)

    creator = User.first || User.create!(phone_number: "0000000000")
    @plan_session.created_by_user_id = creator.id if @plan_session.respond_to?(:created_by_user_id=)

    if @plan_session.save
      SessionMember.create!(plan_session: @plan_session, user: creator)
      InviteLink.create!(plan_session: @plan_session, token: SecureRandom.alphanumeric(8).upcase)

      redirect_to new_plan_session_busy_block_path(@plan_session, user_id: creator.id),
                  notice: "Session created! Add your busy times."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @plan_session = PlanSession.find(params[:id])
    @invite_link = InviteLink.find_by!(plan_session_id: @plan_session.id)
    @join_url = join_url(token: @invite_link.token)

    @members = User.joins(:session_members)
                   .where(session_members: { plan_session_id: @plan_session.id })
  end

  # ✅ MUST be above `private`
  def recommendations
    @plan_session = PlanSession.find(params[:id])

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

  private

  def plan_session_params
    params.require(:plan_session).permit(:title, :window_type, :start_date, :end_date)
  end
end
