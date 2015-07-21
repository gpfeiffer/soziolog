class Label < ActiveRecord::Base
  attr_accessible :amount, :category_id, :transaction_id

  belongs_to :category
  belongs_to :transaction

  delegate :year, to: :transaction

  def sign
    "++-"[amount <=> 0]
  end
end
