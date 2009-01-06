
module DataMapper
  module Form
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
      
      ##
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>)
      end
      
    end
  end
end