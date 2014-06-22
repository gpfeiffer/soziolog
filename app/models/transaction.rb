class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :date, :text
  
  has_many :subscriptions
end
