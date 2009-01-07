
module DataMapper
  module Form
    class Base
      
      DEFAULTS = { :method => :post }
      
      attr_accessor :elements
      
      def initialize name, options
        @elements, @name, @options = '', name, DEFAULTS.merge(options)
      end
      
      def render
        @options[:value] = @elements unless @elements.blank?
        Tag.new(:form, :attributes => @options).render
      end
      alias :to_s :render
      
      def method_missing meth, *args, &block
        element = Elements.send meth, *args, &block
        @elements << element unless element.blank?
      end
      
    end
  end
end