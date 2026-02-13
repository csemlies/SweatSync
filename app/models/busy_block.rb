# == Schema Information
#
# Table name: busy_blocks
#
#  id              :bigint           not null, primary key
#  end_dt          :datetime
#  start_dt        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_session_id :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_busy_blocks_on_plan_session_id                           (plan_session_id)
#  index_busy_blocks_on_plan_session_id_and_start_dt              (plan_session_id,start_dt)
#  index_busy_blocks_on_plan_session_id_and_user_id               (plan_session_id,user_id)
#  index_busy_blocks_on_plan_session_id_and_user_id_and_start_dt  (plan_session_id,user_id,start_dt) UNIQUE
#  index_busy_blocks_on_user_id                                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_session_id => plan_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class BusyBlock < ApplicationRecord
  belongs_to :plan_session
  belongs_to :user

  validates :start_dt, :end_dt, presence: true
  validate :end_after_start

  private

  def end_after_start
    return if start_dt.blank? || end_dt.blank?
    errors.add(:end_dt, "must be after start time") if end_dt <= start_dt
  end
end
