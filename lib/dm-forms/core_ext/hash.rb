
class Hash
  
  ##
  # Converts hash to HTML element attributes.
  #
  # Examples:
  #
  #   { :type => :textfield }                 # => type="textfield"
  #   { :foo => :bar, :something => 'else' }  # => foo="bar" something="else" 
  
  def to_html_attributes
    collect { |k, v| %(#{k}="#{v}") }.join ' '
  end
end