# == Schema Information
#
# Table name: recommended_classes_available_members
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  recommended_class_id :bigint
#  user_id              :bigint
#
# Indexes
#
#  idx_on_recommended_class_id_13cc39c8bd                  (recommended_class_id)
#  idx_unique_reco_members                                 (recommended_class_id,user_id) UNIQUE
#  index_recommended_classes_available_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recommended_class_id => recommended_classes.id)
#  fk_rails_...  (user_id => users.id)
#
class RecommendedClassesAvailableMember < ApplicationRecord
  belongs_to :recommended_class
  belongs_to :user
end

