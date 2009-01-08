
class NilClass
  def to_xml_attributes #:nodoc:
    ''
  end
  alias :to_html_attributes :to_xml_attributes
end

class String
    
  def humanize
    gsub!(/[^a-zA-Z\d]/, ' ')
  end
end

class Symbol
  
  def humanize
    to_s.humanize
  end
end