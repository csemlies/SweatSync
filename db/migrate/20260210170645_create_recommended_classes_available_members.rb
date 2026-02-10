class CreateRecommendedClassesAvailableMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :recommended_classes_available_members do |t|
      t.references :recommended_class, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
