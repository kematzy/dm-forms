
module DataMapper
  module Form
    class Base
      include Elements

      def initialize name
        @name = name
      end
    end
  end
end