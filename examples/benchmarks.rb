
require File.dirname(__FILE__) + '/../lib/dm-forms'

require 'rubygems'
require 'rgauge'

include DataMapper::Form::Helpers

def params
  Hash.new { |h, k| k }
end
public :params

benchmark 'Entire forms', :times => 400 do
  report 'Login' do 
    form :action => '/login' do
      textfield :name, :id => 'username'
      textfield :pass, :id => 'password'
      submit :value => 'Login'
    end
  end
  
  DataMapper::Form::Base.send :include, DataMapper::Form::Labels
  DataMapper::Form::Base.send :include, DataMapper::Form::Descriptions
  DataMapper::Form::Base.send :include, DataMapper::Form::Wrappers
  
  report 'Login with mixins' do 
    form :action => '/login' do
      textfield :name, :id => 'username', :label => 'Username'
      textfield :pass, :id => 'password', :label => 'Password', :description => 'Enter a valid password.'
      submit :value => 'Login'
    end    
  end
end