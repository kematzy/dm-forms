
module DataMapper
  module Form
    class Base
      
      include Tag
      
      attr_reader :model, :origin
      
      # TODO: use origin for params[] etc
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
      end
      
    end
  end
end
