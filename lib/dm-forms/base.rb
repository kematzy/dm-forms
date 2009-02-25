
module DataMapper
  module Form
    class Base
      
      include Tag
      
      attr_reader :model, :origin
      
      # TODO: use origin for params[] etc
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
      end
      
      def form attrs = {}, &block 
        origin.buffer << tag(:form, origin.capture(&block), attrs)
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
          attrs ||= {}
          attrs[:type] = type
          origin.buffer << self_closing_tag(:input, attrs)
        end
      end

    end
  end
end
