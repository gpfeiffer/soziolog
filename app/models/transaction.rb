class Transaction < ActiveRecord::Base
  attr_accessible :amount, :balance_id, :comment, :date, :text
  
  belongs_to :balance
  has_many :subscriptions

  has_many :labels, :dependent => :destroy
  has_many :categories, :through => :labels
end
