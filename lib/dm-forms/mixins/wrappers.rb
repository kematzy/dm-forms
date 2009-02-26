
module DataMapper::Form::Wrappers
  
  def tag name, contents = nil, attrs = {}, &block
    attrs, contents = contents, nil if contents.is_a? Hash
    if name.in? :form, :fieldset, :legend
      super
    else
      wrapper_open(name, attrs) + super + wrapper_close
    end
  end
  
  def self_closing_tag name, attrs = {}
    wrapper_open(name, attrs) + super + wrapper_close
  end
  
  def wrapper_open name, attrs = {}
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