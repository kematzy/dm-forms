
require 'dm-forms'

class String
  def deindent spaces = 6
    gsub /^ {#{spaces},}/, ''
  end
end