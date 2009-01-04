
class Object
  
  ##
  # Converts an object to html element attributes.
  
  def attributize
    to_html_attributes
  end
  alias :attributeize :attributize
  
  def to_html_attributes
    ''
  end
end