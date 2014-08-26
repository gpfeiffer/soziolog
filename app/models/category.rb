class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :labels, :dependent => :destroy
  has_many :transactions, :through => :labels

  def to_s
    name
  end
end
