class AddUniqueIndexToBusyBlocks < ActiveRecord::Migration[8.0]
  def change
    add_index :busy_blocks, [:plan_session_id, :user_id, :start_dt], unique: true
  end
end
