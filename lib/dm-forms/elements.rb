
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
      
      def form name, options = {}, &block
        form = Form::Base.new name, options
        form.instance_eval &block if block_given?
        form.render
      end
      
      ##
      # Generates a fieldset.
      
      def fieldset name, options = {}, &block
        legend_value = options.has_key?(:legend) ? options.delete(:legend) : name.humanize.capitalize
        options = { :class => "fieldset-#{name}" }.merge options
        options[:value] = "\n" << legend(legend_value) << (options.delete(:value) || '')
        options[:value] << capture_elements(&block) if block_given?
        tag :fieldset, :attributes => options
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
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>) unless text.blank?
      end
      
      ##
      # Capture results of elements called within +block+.
      
      def capture_elements &block
        capture = class << Object.new
          def self.method_missing meth, *args, &block
            @elements ||= ''
            @elements << Elements.send(meth, *args, &block) unless meth == :render
            @elements
          end
          self
        end
        capture.instance_eval &block
        capture.render
      end
      
    end
  end
end