
class String

  ##
  # String to bool.
  
  def to_bool
    !empty? and self != '0' and self != 'false' and self != 'nil'
  end
  
end

class TrueClass
  
  ##
  # True to bool.
  
  def to_bool
    self
  end
  
end

class FalseClass
  
  ##
  # False to bool.
  
  def to_bool
    self
  end
  
end

class NilClass
  
  ##
  # Nil to bool.
  
  def to_bool
    false
  end
  
end