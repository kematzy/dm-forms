
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
        s = ''
        self_closing = options[:self_closing]
        # TODO: no rescue ... clean up with .blank? or something ... or no options INSIDE attributes? || '' ?
        value = options[:attributes].delete(:value) unless self_closing rescue ''
        label = options[:attributes].delete(:label) rescue nil
        required = ' <em>*</em>' if options[:attributes].delete(:required) rescue ''
        s << %(<label for="#{options[:attributes][:name]}">#{label}#{required}</label>\n) if label
        s << "<#{name} #{options[:attributes].attributize}"
        s << if self_closing
            " />"
          else
            ">#{value}</#{name}>"
          end
        s << "\n"
      end
      
      ##
      # Generates an HTML textfield.
      
      def textfield name, attributes = {}
        attributes.merge! :type => :textfield, :name => name 
        tag :input, :self_closing => true, :attributes => attributes
      end
      
      def textarea name, attributes = {}
        attributes.merge! :name => name
        tag :textarea, :attributes => attributes
      end
    end
  end
end