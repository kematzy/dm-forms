
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dm-forms'
require 'benchmark'

include DataMapper::Form::Elements

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