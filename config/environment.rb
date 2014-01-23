# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sociolog::Application.initialize!

Date::DATE_FORMATS.merge!( :default => "%d/%m/%y" )
