
require File.dirname(__FILE__) + '/../lib/dm-forms'

include DataMapper::Form::Helpers

form :action => '/login' do
  textfield :name, :id => 'username'
  textfield :pass, :id => 'password'
  submit :value => 'Login'
end
