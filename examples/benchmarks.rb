
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'dm-forms'
require 'rubygems'
require 'rgauge'
require 'dm-core'
require 'dm-validations'

DataMapper.setup :default, 'sqlite3::memory:'
include DataMapper::Form::ModelElements

# Not real-world examples ... just for benchmarking purposes

#--
# Models
#++

class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String, :format => /^[\w]+$/
  property :email, String, :format => :email_address
end

DataMapper.auto_migrate!

$user = User.new :name => 'tj', :email => 'invalid email@lame.com'

#--
# Benchmarks
#++

benchmark 'Elements', :times => 100 do
  report 'textarea' do
    textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
  end
end

benchmark 'Entire forms', :times => 100 do
  
  report 'Login' do
    form :login do |f|
      f.textfield :name, :label => 'Username', :required => true
      f.textfield :email, :label => 'Email', :required => true
      f.textfield :pass, :label => 'Password', :required => true
      f.submit :op, :value => 'Login'
    end  
  end
  
  report 'Register' do
    form :register do |f|
      f.fieldset :general do |f|
        f.textfield :name, :label => 'Username', :required => true
        f.textfield :email, :label => 'Email', :required => true
        f.textfield :pass, :label => 'Password', :required => true
        f.password :pass_confirm
      end
      f.fieldset :details do |f|
        f.textfield :city, :label => 'City'
        f.textfield :zip, :label => 'Postal Code'
      end
      f.fieldset :forums do |f|
        f.textarea :signature, :label => 'Signature', :description => 'Enter a signature which will appear below your forum posts.'
      end
      f.submit :op, :value => 'Register'
    end
  end
  
  report 'User with model' do
    form_for $user do |f|
      f.textfield :name, :label => 'Username', :required => true
      f.textfield :email, :label => 'Email', :required => true
      f.submit :op, :value => 'Login'
    end
  end
  
end


