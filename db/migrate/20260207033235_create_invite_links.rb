class CreateInviteLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :invite_links do |t|
      t.references :plan_session, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
