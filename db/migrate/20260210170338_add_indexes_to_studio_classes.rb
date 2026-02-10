class AddIndexesToStudioClasses < ActiveRecord::Migration[7.0]
  def change
    add_index :studio_classes, [:studio_id, :start_dt]
    add_index :studio_classes, :scraped_at
  end
end

