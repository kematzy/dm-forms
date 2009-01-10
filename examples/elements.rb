
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dm-forms'

include DataMapper::Form::Elements

def example before, &block
  puts before << "\n\n"
  puts yield.gsub!(/^/, '    ')
  puts
end

example %(textarea :comments) do
  textarea :comments
end

example %(textarea :comments, :label => 'Comments', :description => 'Tell us what you think') do
  textarea :comments, :label => 'Comments', :description => 'Tell us what you think'
end

example %(textfield :email, :label => 'Email', :required => true) do
  textfield :email, :label => 'Email', :required => true
end

example 'Login' do
  form :login do |f|
    f.textfield :name, :label => 'Username'
    f.textfield :pass, :label => 'Password'
    f.submit :op, :value => 'Login'
  end
end
