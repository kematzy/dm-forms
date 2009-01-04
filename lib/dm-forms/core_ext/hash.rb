
class Hash
  def attributeize
    collect { |k, v| %(#{k}="#{v}") }.join ' '
  end
end