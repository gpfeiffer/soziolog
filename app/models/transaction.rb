class Transaction < ActiveRecord::Base
  attr_accessible :amount, :balance_id, :comment, :date, :text
  
  belongs_to :balance
  has_many :subscriptions

  has_many :labels, :dependent => :destroy
  has_many :categories, :through => :labels

  default_scope :order => :date

  def year
    date.year
  end

  def sign
    "++-"[amount <=> 0]
  end

  def categorized
    labels.map(&:amount).sum
  end
end
