
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dm-forms'

include DataMapper::Form::Elements

puts form :login do
  
end