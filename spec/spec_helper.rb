
require 'dm-forms'
require 'rspec_hpricot_matchers'

Spec::Runner.configure do |config|
  config.include RspecHpricotMatchers
end

def params
  Hash.new { |h, k| k }
end
public :params