class Member < ActiveRecord::Base
  attr_accessible :address, :comment, :email, :forename, :number, :status, :surname, :title

  STATUSES = {
    "O" => "ordinary",
    "S" => "student",
    "H" => "honorary",
    "L" => "life",
    "R" => "retired",
    "D" => "deceased",
    "P" => "???",
    "AMS" => "reciprocal AMS",
    "DMV" => "reciprocal DMV",
    "IMTA" => "reciprocal IMTA",
    "NZMS" => "reciprocal NZMS",
    "RSME" => "reciprocal RSME",
    ## FIXME:  the ones below should all be replaced by one from above.
    "Life member" => "Life member",
    "Retiring 2009" => "Retiring 2009",
    "honorary life member" => "honorary life member", 
    "Hon 95" => "Hon 95", 
    "Retired" => "Retired", 
    "Honorary" => "Honorary",
  }

  validates :status, :presence => true, :inclusion => STATUSES.keys

  def fullname
    "%s %s %s" % [title, forename, surname]
  end

  def name 
    "#{surname}, #{forename}"
  end

  def first_last
    "#{forename} #{surname}"
  end

  def address_line
    address.gsub(/\r?\n/, " ")
  end
end
