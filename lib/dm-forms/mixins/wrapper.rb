
module DataMapper::Form::Labels
  def tag name, contents = nil, attrs = {}, &block
    super :div, super, :class => "form-#{name}"
  end
end