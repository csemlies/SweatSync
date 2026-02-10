class AddIndexToBusyBlocks < ActiveRecord::Migration[7.0]
  def change
    add_index :busy_blocks, [:plan_session_id, :user_id]
    add_index :busy_blocks, [:plan_session_id, :start_dt]
  end
end
