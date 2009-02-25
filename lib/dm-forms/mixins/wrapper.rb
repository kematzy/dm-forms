
module DataMapper::Form::Labels
  def tag name, contents = nil, attrs = {}, &block
    super :div, super, :class => "form-#{name}"
  end
  
  def add_class string, attrs = {}
    attrs[:class] ||= ''
    attrs[:class].add_class string
  end
end