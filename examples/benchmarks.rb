
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dm-forms'
require 'benchmark'

include DataMapper::Form::Elements

puts
puts 'Single element'
Benchmark.bm(25) do |x|
  x.report("10 elements") {
    10.times do
      textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
    end
  }
  x.report("100 elements") {
    100.times do
      textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
    end
  }
  x.report("1000 elements") {
    1000.times do
      textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
    end
  }
end

puts
puts 'Capture elements within a fieldset'
Benchmark.bm(25) do |x|
  x.report("10 elements") {
    10.times do
      fieldset :comments do
        textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
  x.report("100 elements") {
    100.times do
      fieldset :comments do
        textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
  x.report("1000 elements") {
    1000.times do
      fieldset :comments do
        textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
end

# Not real-world examples ... just for benchmarking purposes
puts
puts 'Entire forms'
Benchmark.bm(25) do |x|
  x.report("Login") {
    fieldset :login do
      textfield :name, :label => 'Username', :required => true
      textfield :email, :label => 'Email', :required => true
      textfield :pass, :label => 'Password', :required => true
      submit :op, :value => 'Login'
    end
  }
  
  x.report("Register") {
    fieldset :register do
      fieldset :general do
        textfield :name, :label => 'Username', :required => true
        textfield :email, :label => 'Email', :required => true
        textfield :pass, :label => 'Password', :required => true
        textfield :pass_confirm
      end
      fieldset :details do
        textfield :city, :label => 'City'
        textfield :zip, :label => 'Postal Code'
      end
      fieldset :forums do
        textarea :signature, :label => 'Signature', :description => 'Enter a signature which will appear below your forum posts.'
      end
      submit :op, :value => 'Register'
    end
  }
end