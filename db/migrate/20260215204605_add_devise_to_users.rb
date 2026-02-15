class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def change
    # Add columns only if they don't already exist
    unless column_exists?(:users, :email)
      add_column :users, :email, :string, null: true, default: nil
    end

    unless column_exists?(:users, :phone_number)
      add_column :users, :phone_number, :string, null: true, default: nil
    end

    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end

    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end

    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end

    unless column_exists?(:users, :remember_created_at)
      add_column :users, :remember_created_at, :datetime
    end

    # Add indexes if they don't already exist. Use partial unique index for email
    unless index_exists?(:users, :email, unique: true)
      add_index :users, :email, unique: true, where: "email IS NOT NULL"
    end

    unless index_exists?(:users, :reset_password_token, unique: true)
      add_index :users, :reset_password_token, unique: true
    end
  end
end
