class Member < ActiveRecord::Base
  attr_accessible :address, :bulletin, :comment, :email, :forename, :number, :status, :surname, :title

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

  BULLETIN = %w{ yes no }

  validates :bulletin, :inclusion => BULLETIN

  COLUMNS = %w{n Title Surname Forename Address0 Address1 Address2 Address3 Address4 Address5 Email Status Bulletin}

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

  def address_lines
    postal = address.split(/\r?\n/)
    (6 - postal.size).times do
      postal << ""
    end
    postal[0, 6]
  end

  def to_a
    [ number, title, surname, forename ].concat(address_lines).concat [ email, status, bulletin, comment ]
  end

  def self.to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => 'current database'
    
    sheet.row(0).concat COLUMNS
    
    format = Spreadsheet::Format.new :color => :blue, :weight => :bold
    sheet.row(0).default_format = format
    
    Member.all.each_with_index do |member, i|
      sheet.row(i+1).concat member.to_a
    end
    
    sio = StringIO.new
    book.write(sio)
    return sio.string
  end
end
