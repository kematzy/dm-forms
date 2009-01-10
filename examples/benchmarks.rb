
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
    5.times do
      fieldset :comments do |f|
        f.textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
  x.report("100 elements") {
    50.times do
      fieldset :comments do |f|
        f.textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
  x.report("1000 elements") {
    500.times do
      fieldset :comments do |f|
        f.textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
      end
    end
  }
end

# Not real-world examples ... just for benchmarking purposes
puts
puts 'Entire forms'
Benchmark.bm(25) do |x|
  x.report("Login") {
    form :login do |f|
      f.textfield :name, :label => 'Username', :required => true
      f.textfield :email, :label => 'Email', :required => true
      f.textfield :pass, :label => 'Password', :required => true
      f.submit :op, :value => 'Login'
    end
  }
  
  x.report("Register") {
    form :register do |f|
      f.fieldset :general do |f|
        f.textfield :name, :label => 'Username', :required => true
        f.textfield :email, :label => 'Email', :required => true
        f.textfield :pass, :label => 'Password', :required => true
        f.textfield :pass_confirm
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
  }
end