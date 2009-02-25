
module DataMapper
  module Form
    class Base
      
      include Tag
      
      attr_reader :model, :origin
      
      # TODO: use origin for params[] etc
      
      def initialize model = nil, origin = nil
        @model, @origin = model, origin
      end
      
      %w( textfield submit file button hidden password radio checkbox ).each do |type|
        define_method :"unbound_#{type}" do |attrs|
          attrs ||= {}
          attrs[:type] = type
          self_closing_tag :input, attrs
        end
      end

    end
  end
end
