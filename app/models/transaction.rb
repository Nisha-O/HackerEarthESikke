class Transaction < ActiveRecord::Base

  attr_accessible :account_id, :user_id, :amount, :status, :transaction_type, :transaction_id
  validates_presence_of :user_id


  belongs_to :user
  scope :credited_transactions, lambda{|user_id| where(:user_id=>user_id, :transaction_type=>"credit")} 
  scope :debited_transactions, lambda{|user_id| where(:user_id=>user_id, :transaction_type=>"debit")} 


end
