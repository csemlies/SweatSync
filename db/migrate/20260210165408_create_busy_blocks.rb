class CreateBusyBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :busy_blocks do |t|
      t.references :plan_session, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_dt
      t.datetime :end_dt

      t.timestamps
    end
  end
end
