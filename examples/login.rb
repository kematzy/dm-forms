
require File.dirname(__FILE__) + '/../lib/dm-forms'

include DataMapper::Form::Helpers
DataMapper::Form::Base.send :include, DataMapper::Form::Labels
DataMapper::Form::Base.send :include, DataMapper::Form::Descriptions
DataMapper::Form::Base.send :include, DataMapper::Form::Wrappers

def params
  Hash.new { |h, k| k }
end
public :params

markup = form :action => '/login' do
  textfield :name, :label => 'Username', :description => 'Enter your username.'
  textfield :pass, :label => 'Password', :description => 'Enter your password.'
  submit :value => 'Login'
end

puts markup
