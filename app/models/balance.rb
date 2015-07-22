class Balance < ActiveRecord::Base
  attr_accessible :balance, :date, :previous_id

  default_scope order: :date

  belongs_to :previous, class_name: 'Balance'
  has_one :next, class_name: 'Balance', foreign_key: :previous_id

  has_many :transactions, dependent: :destroy

  validate :date, presence: true, uniqueness: true

  def year
    date.year
  end

  def amount
    transactions.map(&:amount).sum
  end

  def categorized
    transactions.map(&:categorized).sum
  end

  def error
    amount - categorized
  end

  def as_json(options = {})
    super(root: false, only: [:id, :date, :balance]) 
  end
end
