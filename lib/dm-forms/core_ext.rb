
class NilClass
  def to_xml_attributes #:nodoc:
    ''
  end
  alias :to_html_attributes :to_xml_attributes
end

class String
    
  ##
  # Convert to a human readable string.
  #
  # === Examples:
  #    
  #   'im_a_simple.String'.humanize # => 'im a simple String'
  #
  
  def humanize
    gsub(/[^a-zA-Z\d]/, ' ') || self
  end
end

class Symbol
  
  ##
  # Convert to a human readable string. See String#humanize
  
  def humanize
    to_s.humanize
  end
end