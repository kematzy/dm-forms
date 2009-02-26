
module DataMapper
  module Form
    class Base
      
      include Tag

      REGULAR_ELEMENTS = :textarea, :select
      SELF_CLOSING_ELEMENTS = :textfield, :submit, :file, :button, :hidden, :password, :radio, :checkbox
      DEFAULT_VALUE_ELEMENTS = :textarea, :select, :textfield, :radio, :checkbox
      
      attr_reader :model, :origin, :name
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
        @name = model.class.name.downcase.split('::').last
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
          if type == :textarea
            origin.buffer << tag(type, element_value(attrs), attrs)
          else
            origin.buffer << tag(type, attrs)
          end
        end
      end
      
      SELF_CLOSING_ELEMENTS.each do |type|
        define_method :"unbound_#{type}" do |attrs|
          process_unbound_element type, attrs
          origin.buffer << self_closing_tag(:input, attrs)
        end
      end
      
      (SELF_CLOSING_ELEMENTS | REGULAR_ELEMENTS).each do |type|
        define_method :"bound_#{type}" do |*args|
          method, attrs = args.shift, args.shift || {}
          process_bound_element type, method, attrs
          send :"unbound_#{type}", attrs
        end
      end
      
      private 
      
      def process_bound_element type, method, attrs
        attrs[:__name] = method
        attrs[:name] = element_name method
      end
      
      def process_unbound_element type, attrs
        attrs ||= {}
        attrs[:type] = type if type.in? SELF_CLOSING_ELEMENTS
        attrs[:value] = element_value attrs if type.in?(DEFAULT_VALUE_ELEMENTS - REGULAR_ELEMENTS)
        case type
        when :file
          @multipart = true
        when :submit 
          attrs[:name]  ||= 'submit'
          attrs[:value] ||= 'Submit'
        end
        raise ArgumentError, 'form elements must have a name', caller unless attrs.include? :name
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
        model ? "#{name}[#{method}]" : method
      end
      
      def element_value attrs = {}
        # TODO: escape HTML
        model ? model.send(attrs[:__name]) : origin.params[attrs[:name]]
      end
      
    end
  end
end
