class CreateStudios < ActiveRecord::Migration[8.0]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :location
      t.string :source_url

      t.timestamps
    end
  end
end
