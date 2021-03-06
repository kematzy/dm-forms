
module DataMapper::Form::Descriptions
  
  def tag name, contents = nil, attrs = {}, &block
    description = description_tag attrs
    super + description
  end
  
  def self_closing_tag name, attrs = {}
    description = description_tag attrs
    super + description
  end
  
  def description_tag attrs = {}
    (description = attrs.delete(:description)) ? tag(:span, description, :class => 'description') : ''
  end
  
end      