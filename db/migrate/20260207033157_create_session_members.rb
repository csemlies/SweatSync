class CreateSessionMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :session_members do |t|
      t.references :plan_session, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role
      t.datetime :joined_at

      t.timestamps
    end
  end
end
