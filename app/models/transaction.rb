class Transaction < ActiveRecord::Base
  attr_accessible :amount, :comment, :date, :text
end
