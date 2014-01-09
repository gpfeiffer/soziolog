class Member < ActiveRecord::Base
  attr_accessible :address, :comment, :email, :forename, :number, :status, :surname, :title

  def fullname
    "%s %s %s" % [title, forename, surname]
  end

  def name 
    "#{surname}, #{forename}"
  end

end
