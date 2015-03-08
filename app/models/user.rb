class User < ActiveRecord::Base
  attr_accessible :account_id, :email, :mobile, :password, :password_confirmation,:name,:mobile, :is_activated, :wallet_amount
  validates :email, uniqueness: true
  validates :account_id, uniqueness: true
  validates_presence_of :mobile
  has_many :transactions
  has_secure_password
  has_one_time_password

  scope :activated_user, lambda{|id| where(:is_activated=>1,:id=>id) }


end
