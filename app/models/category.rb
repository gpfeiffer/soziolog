class Category < ActiveRecord::Base
  attr_accessible :description, :name, :rank

  has_many :labels, :dependent => :destroy
  has_many :transactions, :through => :labels

  default_scope :order => :rank

  def to_s
    name
  end
end
