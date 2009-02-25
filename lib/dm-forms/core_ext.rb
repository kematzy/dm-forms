
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
  
end