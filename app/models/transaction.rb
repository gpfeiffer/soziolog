class Transaction < ActiveRecord::Base
  attr_accessible :amount, :balance_id, :comment, :date, :text
  
  belongs_to :balance
  has_many :subscriptions, :dependent => :destroy

  has_many :fundings, :dependent => :destroy
  has_many :conferences, :through => :fundings

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

  def error
    amount - categorized
  end

  def number
    m = /\d{5}|MM\d{3}/.match(text)
    return m[0] if m
  end

  def member
    Member.where(number: number).first
  end
end
