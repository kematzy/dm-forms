
module DataMapper
  module Form
    class Base
      
      include Tag
      
      attr_reader :model, :origin
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
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
      
      %w( textarea select ).each do |type|
        define_method :"unbound_#{type}" do |attrs|
          origin.buffer << tag(type, attrs)
        end
      end
      
      %w( textfield submit file button hidden password radio checkbox ).each do |type|
        define_method :"unbound_#{type}" do |attrs|
          @multipart = true if type == 'file'
          attrs ||= {}
          attrs[:type] = type
          origin.buffer << self_closing_tag(:input, attrs)
        end
      end
      
      private 
      
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

    end
  end
end
