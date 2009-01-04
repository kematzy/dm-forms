
module DataMapper
  module Forms
    module Elements
      
      ##
      # Generates a generic HTML +name+ tag. Although this method is 
      # generally used internally by dm-forms, you may utilize it directly
      # passing any of the following +options+.
      #
      # Options:
      #
      #   :self_closing   Wither or not the element should self-close (<br />)
      #   :attributes     Hash of attributes such as :type => :textfield
      #
      
      def tag name, options = {}
        self_closing = options[:self_closing]
        value = options[:attributes].delete(:value) unless self_closing rescue ''
        s = "<#{name} #{options[:attributes].attributize}"
        s << if self_closing
            " />"
          else
            " />#{value}</#{name}>"
          end
      end
      
      ##
      # Generates an HTML textfield.
      
      def textfield name, attributes = {}
        attributes.merge! :type => :textfield, :name => name 
        tag :input, :self_closing => true, :attributes => attributes
      end
    end
  end
end