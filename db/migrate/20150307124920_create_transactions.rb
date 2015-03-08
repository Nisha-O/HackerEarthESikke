class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.integer :account_id
      t.integer :user_id
      t.float :amount
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
