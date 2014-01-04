class Member < ActiveRecord::Base
  attr_accessible :address, :comment, :email, :forename, :number, :status, :surname, :title

  def name
    "%s %s %s" % [title, forename, surname]
  end

end
