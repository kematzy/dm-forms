
module DataMapper::Form::Wrappers
  
  def tag name, contents = nil, attrs = {}, &block
    attrs, contents = contents, nil if contents.is_a? Hash
    unless name.in? :form, :fieldset, :legend, :span, :div, :option, :optgroup
      tag(:div, super, :class => wrapper_classes(name, attrs))
    else
      super
    end
  end
  
  def self_closing_tag name, attrs = {}
    tag :div, super, :class => wrapper_classes(name, attrs)
  end
  
  def wrapper_classes name, attrs = {}
    classes = attrs.include?(:type) ? "form-#{attrs[:type]}" : "form-#{name}"
    classes.add_class "form-#{classify_name(attrs[:name])}"
  end
  
  def classify_name name
    name.to_s.gsub('[', '-').gsub(']', '')
  end
  
end