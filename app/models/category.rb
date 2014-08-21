class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :labels, :dependent => :destroy
  has_many :transactions, :through => :labels
end
