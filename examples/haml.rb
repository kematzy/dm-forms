
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'haml'
require 'dm-forms'

include DataMapper::Form::ModelElements

# Haml does not play very nice with nested Ruby, but then again
# there is relatively nothing that cannot be altered via styling
# so placing forms directly within a Haml view is not entirely
# necessary.
def login_form
  form :login, :action => '/user' do |f|
	  f.textarea :name, :label => 'Name'
	  f.textarea :email, :label => 'Email'
	  f.submit :op, :value => 'Login'
	end
end

puts Haml::Engine.new(File.read(File.dirname(__FILE__) + '/login.haml')).render