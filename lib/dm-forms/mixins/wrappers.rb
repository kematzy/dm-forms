
module DataMapper::Form::Wrappers
  
  def tag name, contents = nil, attrs = {}, &block
    attrs, contents = contents, nil if contents.is_a? Hash
    wrapper_open(name, attrs) + super + wrapper_close
  end
  
  def self_closing_tag name, attrs = {}
     wrapper_open(name, attrs) + super + wrapper_close
  end
  
  def wrapper_open name, attrs = {}
    return '' if name.in?(:form, :fieldset)
    type = attrs.include?(:type) ? attrs[:type] : name
    %(<div class="form-#{type} form-#{classify_name(attrs[:name])}">\n)
  end
  
  def wrapper_close
    "</div>\n"
  end
  
  def classify_name name
    name.to_s.gsub('[', '-').gsub(']', '')
  end
  
end