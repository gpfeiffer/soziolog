class Subscription < ActiveRecord::Base
  attr_accessible :currency, :member_id, :paid_on, :payment, :transaction_id, :value, :year

  belongs_to :member
  belongs_to :transaction

  CURRENCIES = %w{ EUR GBP IEP USD } # ISO 4217 codes

  validates :value, :currency, :member_id, :presence => true
  validates :currency, :inclusion => CURRENCIES

  def payment_confirmation
    <<CONFIRMATION
Dear #{member.fullname},

Your payment of #{currency} #{ApplicationController.helpers.money payment}
for the #{year} IMS subscription with membership ID \##{member.number}
has been received on #{paid_on} with thanks.

With best wishes,
Goetz Pfeiffer
(Treasurer, IMS)
CONFIRMATION
  end

end
