class Balance < ActiveRecord::Base
  attr_accessible :balance, :date, :previous_id

  belongs_to :previous, :class_name => 'Balance'
  has_one :next, :class_name => 'Balance', :foreign_key => :previous_id

  has_many :transactions

  default_scope :order => :date

  validate :date, :presence => true, :uniqueness => true

  def amount
    transactions.map(&:amount).sum
  end

  def error
    balance - (previous.balance + amount)
  end
end
