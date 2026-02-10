# == Schema Information
#
# Table name: session_days
#
#  id              :bigint           not null, primary key
#  day_date        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_session_id :bigint
#
# Indexes
#
#  index_session_days_on_plan_session_id               (plan_session_id)
#  index_session_days_on_plan_session_id_and_day_date  (plan_session_id,day_date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (plan_session_id => plan_sessions.id)
#
class SessionDay < ApplicationRecord
  belongs_to :plan_session

  validates :day_date, presence: true
  validates :day_date, uniqueness: { scope: :plan_session_id }
end

