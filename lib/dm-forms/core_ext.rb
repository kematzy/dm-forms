
class String
  
  ##
  # Merge the +word+ passed into the string. This
  # is useful for adding classes which may already 
  # exist in a string.
  #
  # === Examples: 
  #
  #   'product'.merge_word('sold')        # => "product sold"
  #   'product sold'.merge_word('sold')   # => "product sold"
  #
  
  def merge_word word
    self << " #{word}" unless split.include? word
    self
  end
  alias :add_class :merge_word
  
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

class Hash
  
  ##
  # Delete key-value pairs, returning the values found
  # using the +keys+ passed. Aliased as extract!
  #
  #   options = { :width => 25, :height => 100 }
  #   width, height = options.delete_at :width, :height  
  #
  #   width   # => 25
  #   height  # => 100
  #   options # => {}
  #
  
  def delete_at *keys
    keys.map { |key| delete key }
  end
  alias :extract! :delete_at
  
end