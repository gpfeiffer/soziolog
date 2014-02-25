class Doctorate < ActiveRecord::Base
  attr_accessible :advisor, :first, :genealogy_id, :last, :thesis, :title, :university, :year
end
