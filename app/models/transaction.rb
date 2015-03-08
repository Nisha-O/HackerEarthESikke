class Transaction < ActiveRecord::Base

  attr_accessible :account_id, :user_id, :amount, :status, :type, :transaction_id
  validates_presence_of :user_id
  validates :transaction_id, uniqueness: true


  belongs_to :user


end
