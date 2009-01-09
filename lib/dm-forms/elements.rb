
module DataMapper
  module Form
    module Elements
      
      module_function
      
      ##
      # Generates a generic HTML +name+ tag. Although this method is 
      # generally used internally by dm-forms, you may utilize it directly
      # passing any of the following +options+.
      #
      # === Options:
      #
      #   :self_closing   Wither or not the element should self-close (<br />)
      #   :attributes     Hash of attributes such as :type => :textfield
      #
      
      def tag name, options = {}, &block
        Tag.new(name, options, &block).render
      end
      
      ##
      # Generates a form.
      
      def form name, options = {}, &block
        options = { :method => :post, :id => "form-#{name}" }.merge options
        tag :form, :attributes => options, &block
      end
      
      ##
      # Generates a fieldset.
      
      def fieldset name, options = {}, &block
        legend_value = options.has_key?(:legend) ? options.delete(:legend) : name.humanize.capitalize
        options = { :class => "fieldset-#{name}" }.merge options
        options[:value] = "\n" << legend(legend_value) << (options.delete(:value) || '')
        tag :fieldset, :attributes => options, &block
      end
      
      ##
      # Generates a label.
      
      def label value, options = {}
        value << ':'
        value << '<em>*</em>' if options.delete :required
        %(<label for="#{options[:for]}">#{value}</label>\n)
      end
      
      ##
      # Generates a legend.
      
      def legend value
        %(<legend>#{value}</legend>)
      end
      
      ##
      # Generates a textfield.
      
      def textfield name, options = {}
        options = { :type => :textfield, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a textarea.
      
      def textarea name, options = {}, &block
        options = { :name => name }.merge options
        tag :textarea, :attributes => options, &block
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
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>) unless text.blank?
      end
      
      ##
      # Capture results of elements called within +block+.
      
      def capture_elements &block
        raise ArgumentError, 'Block must be passed to capture elements', caller unless block_given?
        c = class << Object.new
          def self.method_missing meth, *args, &block
            @elements ||= ''
            @elements << Elements.send(meth, *args, &block) unless meth == :render
            @elements
          end
          self
        end
        c.instance_eval &block
        c.render
      end
      
    end
  end
end