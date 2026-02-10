class AddUniqueIndexToSessionDays < ActiveRecord::Migration[7.0]
  def change
    add_index :session_days, [:plan_session_id, :day_date], unique: true
  end
end
