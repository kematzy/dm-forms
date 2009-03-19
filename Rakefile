
require 'rubygems'
require 'rake'
require 'echoe'
require './lib/dm-forms.rb'

Echoe.new("dm-forms", DataMapper::Form::VERSION) do |p|
  p.author = "TJ Holowaychuk"
  p.email = "tj@vision-media.ca"
  p.summary = "DataMapper model form generation"
  p.url = "http://github.com/visionmedia/dm-forms"
  p.runtime_dependencies = ['dm-core']
  p.development_dependencies = ['rspec_hpricot_matchers']
end

Dir['tasks/**/*.rake'].sort.each { |lib| load lib }