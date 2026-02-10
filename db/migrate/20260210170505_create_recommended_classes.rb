class CreateRecommendedClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :recommended_classes do |t|
      t.references :plan_session, foreign_key: true
      t.references :studio_class, foreign_key: true
      t.integer :rank
      t.integer :score
      t.text :rationale

      t.timestamps
    end
  end
end
