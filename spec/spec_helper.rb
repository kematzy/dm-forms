
require 'dm-forms'

class String
  def deindent
    gsub /^ */, ''
  end
end