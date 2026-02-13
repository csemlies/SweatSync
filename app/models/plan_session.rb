# == Schema Information
#
# Table name: plan_sessions
#
#  id                 :bigint           not null, primary key
#  end_date           :date
#  start_date         :date
#  status             :string
#  title              :string
#  window_type        :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by_user_id :integer
#
# Indexes
#
#  idx_unique_plan_sessions_creator_dates_title  (created_by_user_id,start_date,end_date,title) UNIQUE
#
class PlanSession < ApplicationRecord
  has_many :session_members, dependent: :destroy
  has_many :users, through: :session_members

  has_many :busy_blocks, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:start_date, :end_date, :created_by_user_id],
                                case_sensitive: false }

end
