
require 'dm-forms'

class String
  def deindent spaces = 6
    gsub /^ {0,#{spaces}}/, ''
  end
end