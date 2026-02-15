class InvitesController < ApplicationController
  def new
    @token = params[:token]
    @invite_link = InviteLink.find_by(token: @token)
    @plan_session = @invite_link&.plan_session

    @default_name = "Name"
    @default_phone = "000-000-0000"
  end

  def create
    token = params[:token]
    phone = params[:phone_number].to_s.gsub(/\D/, "")
    name = params[:name].to_s.strip

    invite_link = InviteLink.find_by!(token: token)
    plan_session = invite_link.plan_session

    user = User.find_or_initialize_by(phone_number: phone)
    user.name = name if user.name.blank?
    user.save!

    SessionMember.find_or_create_by!(plan_session: plan_session, user: user)

    # persist current user in session so nav and member label work
    session[:user_id] = user.id

    redirect_to new_plan_session_busy_block_path(plan_session, user_id: user.id),
                notice: "You're in! Add your busy times."
  end
end
