class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :account_id
      t.integer :mobile, :limit => 5
      t.string :name
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.string :otp_secret_key
      t.float :wallet_amount
      t.boolean :is_activated, :default=>0

      t.timestamps
    end
  end
end
