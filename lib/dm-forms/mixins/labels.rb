
module DataMapper::Form::Labels
  def tag name, contents = nil, attrs = {}, &block
    if attrs.includes? :label
      %(<label for="#{name}">#{attrs.delete(:label)}</label>) + super
    else
      super
    end
  end
end