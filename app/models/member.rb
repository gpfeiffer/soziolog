# -*- coding: utf-8 -*-
class Member < ActiveRecord::Base
  attr_accessible :address, :bulletin, :comment, :email, :forename, :number, :status, :reciprocal, :surname, :title

  has_many :subscriptions

  default_scope :order => [:surname, :forename]

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
    "P" => "pending",
  }

  FEES = {
    "O" => 2500,
    "S" => 1250,
    "H" => 0,
    "L" => 0,
    "R" => 1250,
    "I" => 16000,
    "N" => 0,
    "D" => 0,
    "C" => 1250,
    "P" => 0,
  }

  BULLETIN = %w{ yes no }

  validates :number, :presence => true, :uniqueness => true
  validates :status, :presence => true, :inclusion => STATUSES.keys
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

  def paying?
    "SCOR".include? status    
  end

  def arrears?
    "RISCO".include? status and not subscriptions.map(&:year).include? '2014' and comment != "ITT paying"
  end

  def first_year
    (number[0, 2].to_i - 1970) % 100 + 1970
  end

  def fees_decimal
    cents = FEES[status]
    return nil if cents.blank?
    return "-#{fees_decimal(-cents)}" if cents < 0
    e, c = cents.divmod 100
    c = "%02d" % c
    "#{e}.#{c}"
  end

  def arrears(year)
    year = year
    return 0 if year < first_year
    return 0 if subscriptions.map(&:year).include? year.to_s
    return FEES[status]
  end

  def institute
    Member.find_by_number(self.number[0,4]) if status == "N"
  end

  def institutional_name
    address.split("\n")[0,2].join(", ") if status == "I"
  end

  # which student nominations are currently vacant
  def vacant_nominations
    if status == 'I'
      10.times.map { |i| "#{number}#{i}" } - nominees.map(&:number)
    end
  end

  def acronym
    surname[/\(.+\)/].delete("()") if status == "I"
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
    [ number, title, surname, forename ].concat(address_lines).concat [ email, status, bulletin ]
  end

  def self.to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => 'bulletin'
    
    sheet.row(0).concat COLUMNS
    
    format = Spreadsheet::Format.new :color => :blue, :weight => :bold
    sheet.row(0).default_format = format
    
    members = Member.where(:bulletin => "yes").group_by(&:status)
    members = "HLOCRSN".split("").map { |c| members[c] }.sum
    members.each_with_index do |member, i|
      sheet.row(i+1).concat member.to_a
    end
    
    sio = StringIO.new
    book.write(sio)
    return sio.string
  end

  # FIXME: these letters should really be erb templates ...
  def invoice_subscription(year = Date.today.year)
    <<LETTER
Dear #{fullname},

I am writing in connection with the renewal of #{acronym}'s institutional
membership of the Irish Mathematical Society. The membership fee for
#{year} is €#{FEES['I']/100} - I have attached an invoice to that effect.

If you would like to pay by electronic transfer, our bank account
details are as follows:-

Name:      Irish Mathematical Society
Branch:    Bank of Ireland, Maynooth
Sort Code: 901503
A/C No.:   57781485
BIC:       BOFIIE2D
IBAN:      IE47 BOFI 9015 0357 7814 85

As an institutional member, #{acronym} is entitled to nominate up to 10
student members. The current student nominees we have on file are

#{nominees.map(&:name).join("\n")}

Please let me know who you would like to nominate for the coming year
and don't hesitate to contact me with any queries.

With best wishes,
Goetz Pfeiffer
(Treasurer, IMS)
LETTER
  end
end
