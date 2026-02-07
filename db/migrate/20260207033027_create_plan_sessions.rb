class CreatePlanSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :plan_sessions do |t|
      t.string :title
      t.integer :created_by_user_id
      t.string :window_type
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
