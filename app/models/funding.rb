class Funding < ActiveRecord::Base
  attr_accessible :amount, :conference_id, :transaction_id

  belongs_to :conference
  belongs_to :transaction
end
