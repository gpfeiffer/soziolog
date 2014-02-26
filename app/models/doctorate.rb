class Doctorate < ActiveRecord::Base
  attr_accessible :advisor, :first, :genealogy_id, :last, :thesis, :title, :university, :year

  def first_last
    "#{first} #{last}"
  end

  def last_first
    "#{last}, #{first}"
  end

  def genealogy_url
    "http://genealogy.math.ndsu.nodak.edu/id.php?id=#{genealogy_id}"
  end
end
