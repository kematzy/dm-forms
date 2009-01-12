
require 'dm-forms'
require 'rspec_hpricot_matchers'
include RspecHpricotMatchers
  
class String
  def deindent spaces = 6
    gsub /^ {0,#{spaces}}/, ''
  end
end