
module DataMapper::Form::Wrapper
  
  def tag name, contents = nil, attrs = {}, &block
    wrapper_open(name, attrs) + super + wrapper_close
  end
  
  def self_closing_tag name, attrs = {}
     wrapper_open(name, attrs) + super + wrapper_close
  end
  
  def wrapper_open name, attrs = {}
    type = attrs.include? :type ? attrs[:type] : name
    %(<div class="form-#{type} form-#{attrs[:name]}">)
  end
  
  def wrapper_close
    '</div>'
  end
  
end