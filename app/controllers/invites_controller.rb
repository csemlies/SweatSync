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

    session[:user_id] = user.id

    redirect_to new_plan_session_busy_block_path(plan_session, user_id: user.id),
            notice: "You're in! Add your busy times."
  end
end
