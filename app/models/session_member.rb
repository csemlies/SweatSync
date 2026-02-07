# == Schema Information
#
# Table name: session_members
#
#  id              :bigint           not null, primary key
#  joined_at       :datetime
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_session_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_session_members_on_plan_session_id  (plan_session_id)
#  index_session_members_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_session_id => plan_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class SessionMember < ApplicationRecord
  belongs_to :plan_session
  belongs_to :user
end
