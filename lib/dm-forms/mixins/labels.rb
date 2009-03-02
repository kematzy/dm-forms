
module DataMapper::Form::Labels
  
  def tag name, contents = nil, attrs = {}, &block
    label_tag(attrs) +  super
  end
  
  def self_closing_tag name, attrs = {}
    label_tag(attrs) +  super
  end
  
  def label_tag attrs = {}
    (label = attrs.delete(:label)) ? tag(:label, label, :for => attrs[:name]) : ''
  end
  
end