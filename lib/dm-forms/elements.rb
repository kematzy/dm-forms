
module DataMapper
  module Forms
    module Elements
      
      PREVENT_CLASSES_ON_ELEMENTS = :form, :label
      
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
        attributes[:class] = element_class(name, options) if add_element_class? name
        self_closing = options[:self_closing]
        value = attributes.delete(:value) unless self_closing rescue ''
        label = attributes.delete(:label) || attributes.delete(:title) rescue nil
        label_required = attributes.delete(:required) rescue false
        description = attributes.delete(:description) rescue false
        after = "\n" << attributes.delete(:after) rescue ''
        before = attributes.delete(:before) << "\n" rescue ''
        s << before.to_s
        s << self.label(label, :for => attributes[:name], :required => label_required) if label
        s << "<#{name} #{attributes.to_html_attributes}"
        s << if self_closing
            " />"
          else
            ">#{value}</#{name}>"
          end
        s << desc(description) if description
        s << after.to_s
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
      
      ##
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>)
      end
      
      private 
      
      ##
      # Generates element class(es) such as form-submit, etc.
      
      def element_class name, options = {}
        suffix = name == :input ? options[:attributes][:type] : name
        "form-#{suffix} form-#{options[:attributes][:name]}"
      end
      
      def add_element_class? name #:nodoc:
        !PREVENT_CLASSES_ON_ELEMENTS.include? name
      end
      
    end
  end
end