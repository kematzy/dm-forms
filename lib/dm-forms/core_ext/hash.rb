
class Hash
  def to_html_attributes
    collect { |k, v| %(#{k}="#{v}") }.join ' '
  end
end