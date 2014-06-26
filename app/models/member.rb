class Member < ActiveRecord::Base
  attr_accessible :address, :bulletin, :comment, :email, :forename, :number, :status, :reciprocal, :surname, :title

  has_many :subscriptions

  STATUSES = {
    "O" => "ordinary",
    "S" => "student",
    "H" => "honorary",
    "L" => "life",
    "R" => "retired",
    "I" => "institutional",
    "N" => "nominated",
    "D" => "discontinued",
    "C" => "reciprocal",
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

  def to_s
    name
  end

  def active?
    "SCHNORL".include? status    
  end

  def arrears?
    "RISCO".include? status and not subscriptions.map(&:year).include? '2014' and comment != "ITT paying"
  end

  def institute
    Member.find_by_number(self.number[0,4]) if status == "N"
  end

  def institutional_name
    address.split("\n")[0,2].join(", ") if status == "I"
  end

  def nominees
    Member.select { |x| x.status == "N" and x.number[0,4] == self.number } if status == "I"
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
