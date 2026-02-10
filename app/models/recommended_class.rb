# == Schema Information
#
# Table name: recommended_classes
#
#  id              :bigint           not null, primary key
#  rank            :integer
#  rationale       :text
#  score           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_session_id :bigint
#  studio_class_id :bigint
#
# Indexes
#
#  idx_unique_recommendations                    (plan_session_id,studio_class_id) UNIQUE
#  index_recommended_classes_on_plan_session_id  (plan_session_id)
#  index_recommended_classes_on_studio_class_id  (studio_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_session_id => plan_sessions.id)
#  fk_rails_...  (studio_class_id => studio_classes.id)
#
class RecommendedClass < ApplicationRecord
  belongs_to :plan_session
  belongs_to :studio_class

  has_many :recommended_classes_available_members, dependent: :destroy
  has_many :available_members, through: :recommended_classes_available_members, source: :user

  validates :rank, presence: true
end
