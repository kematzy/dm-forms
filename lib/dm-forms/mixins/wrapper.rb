
module DataMapper::Form::Builder::Labels
  # TODO: other should use super too? multiple supers?
  def tag name, contents = nil, attrs = {}, &block
    super :div, super, :class => "form-#{name}"
  end
end