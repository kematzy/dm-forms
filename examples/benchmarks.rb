
require File.dirname(__FILE__) + '/../lib/dm-forms'

require 'rubygems'
require 'rgauge'

include DataMapper::Form::Helpers

def params
  Hash.new { |h, k| k }
end
public :params

benchmark 'Entire forms', :times => 10 do
  report 'Login' do 
    form :action => '/login' do
      textfield :name, :id => 'username'
      textfield :pass, :id => 'password'
      submit :value => 'Login'
    end
  end
end