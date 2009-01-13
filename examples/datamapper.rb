
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dm-forms'
require 'dm-core'
require 'dm-validations'

include DataMapper::Form::ModelElements
DataMapper.setup :default, 'sqlite3::memory:'

class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String, :format => /^[\w]+$/
  property :email, String, :format => :email_address
end

DataMapper.auto_migrate!

user = User.new :name => 'tj', :email => 'invalid email@lame.com'

s = errors_for(user)
s << form_for(user, :action => '/user') do |f|
  f.textarea :name
  f.textarea :email
  f.submit :op, :value => 'Add'
end
puts s

user.email = 'tj@vision-media.ca'
user.save

s = errors_for(user)
s << form_for(user, :action => '/user') do |f|
  f.textarea :name, :label => 'Name'
  f.textarea :email, :label => 'Email'
  f.submit :op, :value => 'Update'
end
puts s