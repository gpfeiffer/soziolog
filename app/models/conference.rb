class Conference < ActiveRecord::Base
  attr_accessible :applicant, :call, :date, :description, :funding, :host, :name
end
