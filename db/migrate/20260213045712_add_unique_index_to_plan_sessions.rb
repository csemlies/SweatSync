class AddUniqueIndexToPlanSessions < ActiveRecord::Migration[8.0]
  def change
    add_index :plan_sessions,
              [:created_by_user_id, :start_date, :end_date, :title],
              unique: true,
              name: "idx_unique_plan_sessions_creator_dates_title"
  end
end
