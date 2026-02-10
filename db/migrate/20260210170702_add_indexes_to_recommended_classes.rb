class AddIndexesToRecommendedClasses < ActiveRecord::Migration[7.0]
  def change
    add_index :recommended_classes,
              [:plan_session_id, :studio_class_id],
              unique: true,
              name: "idx_unique_recommendations"

    add_index :recommended_classes_available_members,
              [:recommended_class_id, :user_id],
              unique: true,
              name: "idx_unique_reco_members"
  end
end
