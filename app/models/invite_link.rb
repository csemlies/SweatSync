# == Schema Information
#
# Table name: invite_links
#
#  id              :bigint           not null, primary key
#  token           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_session_id :bigint
#
# Indexes
#
#  index_invite_links_on_plan_session_id  (plan_session_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_session_id => plan_sessions.id)
#
class InviteLink < ApplicationRecord
  belongs_to :plan_session
end
