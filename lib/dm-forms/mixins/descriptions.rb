
module DataMapper::Form::Builder::Descriptions
  def tag name, contents = nil, attrs = {}, &block
    if attrs.includes? :description
      super + %(<span class="description">#{attrs.delete(:description)}</span>)
    else
      super
    end
  end
end      