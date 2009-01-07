
module DataMapper
  module Form
    class Base
      
      attr_accessor :elements
      
      def initialize name, options
        @elements, @name, = '', name
        @options = { :method => :post, :id => "form-#{@name}" }.merge options
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