
module DataMapper
  module Forms
    module Elements
      
      module_function
      
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
        Tag.new(name, options).render
      end
      
      ##
      # Generates a form. Accepts an optional +block+ to which contains
      # the inner html for this form element.
      
      def form name, options = {}, &block

        options[:value] = yield '' if block_given?
        options = { :method => :post }.merge options
        tag :form, :attributes => options
      end
      
      ##
      # Generates a label.
      
      def label value, options = {}
        value << ':'
        value << '<em>*</em>' if options.delete :required
        %(<label for="#{options[:for]}">#{value}</label>\n)
      end
      
      ##
      # Generates a textfield.
      
      def textfield name, options = {}
        options = { :type => :textfield, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a textarea.
      
      def textarea name, options = {}
        options = { :name => name }.merge options
        tag :textarea, :attributes => options
      end
            
      ##
      # Generates a submit button.
      
      def submit name, options = {}
        options = { :type => :submit, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a button.
      
      def button name, options = {}
        options = { :type => :button, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a button.
      
      def button name, options = {}
        options = { :type => :button, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>) unless text.blank?
      end
      
    end
  end
end