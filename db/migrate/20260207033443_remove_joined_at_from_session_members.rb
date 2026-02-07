class RemoveJoinedAtFromSessionMembers < ActiveRecord::Migration[8.0]
  def change
    remove_column :session_members, :joined_at, :datetime
  end
end
