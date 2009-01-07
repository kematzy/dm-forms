
module DataMapper
  class Form
    include Forms::Elements
    
    def initialize name
      @name = name
    end
  end
end