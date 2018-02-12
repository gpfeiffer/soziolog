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

  TAB1, TAB2 = 10, 32
  def self.from_csv(row)
    debit, credit, balance = row[TAB2+1..-1].split(',')
    h = {
      date: Date.parse(row[0..TAB1-1]),
      text: row[TAB1+1..TAB2-1].strip,
      amount: (100 * (credit.to_d - debit.to_d)).to_i
    }
    puts h.inspect
    Transaction.new(h)
  end
end
