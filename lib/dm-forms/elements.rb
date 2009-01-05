
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
        attributes = options[:attributes]
        self_closing = options[:self_closing]
        value = options[:attributes].delete(:value) unless self_closing rescue ''
        label = options[:attributes].delete(:label) || options[:attributes].delete(:title) rescue nil
        label_required = options[:attributes].delete(:required) rescue false
        s << self.label(label, :for => options[:attributes][:name], :required => label_required) if label
        s << "<#{name} #{attributes.to_html_attributes}"
        s << if self_closing
            " />"
          else
            ">#{value}</#{name}>"
          end
        s << "\n"
      end
      
      #--
      # These methods could use a little DRY love, however for documentation 
      # and IDE purposes these element methods are not created dynamically.
      #++
      
      ##
      # Generates a form.
      
      def form name, options = {}
        options = { :method => :post }.merge! options
        tag :form, :attributes => options
      end
      
      ##
      # Generates a label.
      
      def label value, options = {}
        value << ':'
        value << '<em>*</em>' if options.delete :required
        options.merge! :value => value
        tag :label, :attributes => options
      end
      
      ##
      # Generates a textfield.
      
      def textfield name, options = {}
        options.merge! :type => :textfield, :name => name 
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a textarea.
      
      def textarea name, options = {}
        options.merge! :name => name
        tag :textarea, :attributes => options
      end
            
      ##
      # Generates a submit button.
      
      def submit name, options = {}
        options.merge! :type => :submit, :name => name
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a button.
      
      def button name, options = {}
        options.merge! :type => :button, :name => name
        tag :input, :self_closing => true, :attributes => options
      end
    end
  end
end