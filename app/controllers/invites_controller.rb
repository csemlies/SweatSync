class InvitesController < ApplicationController
  def new
    @token = params[:token]
    @invite_link = InviteLink.find_by(token: @token)
    @plan_session = @invite_link&.plan_session
  end

  def create
    token = params[:token]
    phone = params[:phone_number].to_s.gsub(/\D/, "") # keep digits only
    name  = params[:name].to_s.strip

    invite_link = InviteLink.find_by!(token: token)
    plan_session = invite_link.plan_session

    # Create/find user by phone & name
    user = User.find_or_initialize_by(phone_number: phone)
    user.name = name if user.name.blank?
    user.save!

    # Add as member (avoid duplicates)
    SessionMember.find_or_create_by!(plan_session: plan_session, user: user)

    redirect_to new_busy_block_path(plan_session_id: plan_session.id, user_id: user.id), notice: "Joined! Add your busy times."
  end
end
