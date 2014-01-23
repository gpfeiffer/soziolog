class Conference < ActiveRecord::Base
  attr_accessible :applicant, :call, :date, :description, :funding, :host, :length, :name

  def first_day 
    date
  end

  def last_day
    date + (length - 1)
  end

  def dates
    "#{first_day}" + (length > 1 ? " - #{last_day}" : "")
  end
end
