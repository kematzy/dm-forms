
require 'dm-forms'
require 'rspec_hpricot_matchers'

Spec::Runner.configure do |config|
  config.include RspecHpricotMatchers
end
  
class String
  def dedent spaces = 6
    gsub /^ {0,#{spaces}}/, ''
  end
end