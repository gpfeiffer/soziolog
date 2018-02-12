class Balance < ActiveRecord::Base
  attr_accessible :balance, :date, :previous_id

  default_scope order: :date

  belongs_to :previous, class_name: 'Balance'
  has_one :next, class_name: 'Balance', foreign_key: :previous_id

  has_many :transactions, dependent: :destroy

  validates :date, presence: true, uniqueness: true

  # import transactions from csv file
  def self.import(file)
    puts file.path
    transactions = File.open(file.path)
    headers = transactions.readline
    transactions.each do |row|
      transaction = Transaction.from_csv(row)
      puts transaction.inspect
      balance = Balance.find_or_create_by_date(transaction.date)
      if not balance.previous
        puts "NEW!!"
        balance.previous = Balance.where("date < ?", transaction.date).last
        balance.balance = balance.previous.balance
        balance.save
      end
      puts balance.inspect
      balance.add_transaction(transaction)
    end
  end

  def add_transaction(transaction)
    transactions << transaction
    update_attribute(:balance, balance + transaction.amount)
  end

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
