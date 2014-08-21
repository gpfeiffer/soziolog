class Label < ActiveRecord::Base
  attr_accessible :amount, :category_id, :transaction_id

  belongs_to :category
  belongs_to :transaction
end
