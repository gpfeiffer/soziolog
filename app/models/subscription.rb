class Subscription < ActiveRecord::Base
  attr_accessible :member_id, :paid_on, :payment, :transaction_id, :value, :year

  belongs_to :member
  belongs_to :transaction
end
