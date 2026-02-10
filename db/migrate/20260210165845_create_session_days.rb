class CreateSessionDays < ActiveRecord::Migration[8.0]
  def change
    create_table :session_days do |t|
      t.references :plan_session, foreign_key: true
      t.date :day_date

      t.timestamps
    end
  end
end
