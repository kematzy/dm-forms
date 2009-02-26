
module DataMapper
  module Form
    class Base
      
      REGULAR_ELEMENTS = :textarea, :select
      SELF_CLOSING_ELEMENTS = :textfield, :submit, :file, :button, :hidden, :password, :radio, :checkbox
      
      include Tag
      
      attr_reader :model, :origin
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
        @name = @model.class.name.snake_case.split('/').last
      end
      
      def form attrs = {}, &block
        captured = origin.capture &block
        faux_method = process_form_attrs attrs 
        origin.buffer << tag(:form, faux_method + captured, attrs)
      end
      
      def fieldset attrs = {}, &block
        legend_tag = (legend = attrs.delete(:legend)) ? tag(:legend, legend) : ''
        origin.buffer << tag(:fieldset, legend_tag + origin.capture(&block), attrs)
      end
      
      REGULAR_ELEMENTS.each do |type|
        define_method :"unbound_#{type}" do |attrs|
          process_unbound_element type, attrs
          origin.buffer << tag(type, attrs)
        end
      end
      
      SELF_CLOSING_ELEMENTS.each do |type|
        define_method :"unbound_#{type}" do |attrs|
          process_unbound_element type, attrs
          origin.buffer << self_closing_tag(:input, attrs)
        end
      end
      
      (SELF_CLOSING_ELEMENTS | REGULAR_ELEMENTS).each do |type|
        define_method :"bound_#{type}" do |method, attrs|
          process_bound_element type, method, attrs
          send :"unbound_#{type}", attrs
        end
      end
      
      private 
      
      def process_bound_element type, method, attrs
        attrs ||= {}
        attrs[:name] = element_name method
      end
      
      def process_unbound_element type, attrs
        attrs ||= {}
        attrs[:type] = type if type.in? SELF_CLOSING_ELEMENTS
        @multipart = true if type == :file
      end
      
      def process_form_attrs attrs = {}
        attrs[:method] ||= :post
        method = attrs[:method] 
        attrs[:method] = :post if attrs[:method] != :get
        attrs[:enctype] = 'multipart/form-data' if @multipart || attrs.delete(:multipart)
        method.in?(:post, :get) ? '' : faux_method(method)
      end

      def faux_method method
        unbound_hidden :name => '_method', :value => method
      end
      
      def considered_true? value 
        value && value != "0" && value != 0
      end
      
      def element_name method 
        @model ? "#{@name}[#{method}]" : method
      end
      
      def element_value method 
        # TODO: fix params issue
        value = @model ? @model.send(method) : origin.params[method]
        value.to_s.escape_html
      end
      
    end
  end
end
