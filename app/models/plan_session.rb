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
class PlanSession < ApplicationRecord
end
