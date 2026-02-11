class InvitesController < ApplicationController
  def new
    @token = params[:token]
    @invite_link = InviteLink.find_by(token: @token)
    @plan_session = @invite_link&.plan_session
  end

  def create
    token = params[:token]
    phone = params[:phone_number].to_s.gsub(/\D/, "") # keep digits only

    invite_link = InviteLink.find_by!(token: token)
    plan_session = invite_link.plan_session

    # Create/find user by phone
    user = User.find_or_create_by!(phone_number: phone)

    # Add as member (avoid duplicates)
    SessionMember.find_or_create_by!(plan_session: plan_session, user: user)

    redirect_to plan_session_path(plan_session), notice: "Joined session!"
  end
end
