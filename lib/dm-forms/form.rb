
module DataMapper
  module Form
    class Base
      
      DEFAULTS = { :method => :post }
      
      def initialize name, options
        @name, @options = name, DEFAULTS.merge(options)
      end
      
      def render
        Tag.new(:form, :attributes => @options).render
      end
      alias :to_s :render
      
      def method_missing meth, *args, &block
        p meth
      end
      
    end
  end
end