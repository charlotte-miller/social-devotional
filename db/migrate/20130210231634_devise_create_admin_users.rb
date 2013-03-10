class DeviseCreateAdminUsers < ActiveRecord::Migration
  def change
    create_table(:admin_users) do |t|
      # Greetings
      t.string  :first_name, :limit => 60
      t.string  :last_name,  :limit => 60
      t.integer :user_id

      ## Database authenticatable
      t.string :email,              :null => false, :default => "", :limit => 80
      t.string :encrypted_password, :null => false, :default => ""

      ## Encryptable
      t.string :password_salt

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps
    end

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true
    add_index :admin_users, :confirmation_token,   :unique => true
    add_index :admin_users, :unlock_token,         :unique => true
  end
end
