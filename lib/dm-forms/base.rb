
module DataMapper
  module Form
    class Base
      
      attr_reader :model, :origin
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
      end
      
    end
  end
end
