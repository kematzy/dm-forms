
class NilClass
  def to_xml_attributes #:nodoc:
    ''
  end
  alias :to_html_attributes :to_xml_attributes
end