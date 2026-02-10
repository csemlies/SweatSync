class CreateStudioClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :studio_classes do |t|
      t.references :studio, foreign_key: true
      t.string :class_name
      t.string :instructor
      t.datetime :start_dt
      t.datetime :end_dt
      t.string :difficulty
      t.string :modality
      t.string :source_url
      t.datetime :scraped_at

      t.timestamps
    end
  end
end
