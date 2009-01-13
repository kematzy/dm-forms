
module DataMapper
  module Form
    module Elements
      
      ##
      # Proxy object for capturing elements. See Elements#capture_elements.
      
      class Proxy
        def initialize model = nil
          @model = model
        end

        def method_missing meth, *args, &block
          if @model and @model.errors.on args.first
            ((args[1] ||= {})[:class] ||= '') << ' error'
          end
          (@elements ||= []) << Elements.send(meth, *args, &block)
        end
      end
      
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
      # Generates a description.
      
      def desc text
        %(\n<p class="description">#{text}</p>) unless text.blank?
      end
           
      ##
      # Generates an option.
      
      def option value, title
        %(<option value="#{value}">#{title}</option>\n)
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
      # Generates a textfield.
      
      def textfield name, options = {}
        options = { :type => :textfield, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a password field.
      
      def password name, options = {}
        options = { :type => :password, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Generates a checkbox.
      
      def checkbox name, options = {}
        options = { :type => :checkbox, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options        
      end
      
      ##
      # Generates a hidden field.
      
      def hidden name, options = {}
        options = { :type => :hidden, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options        
      end
      
      ##
      # Generates a radio button.
      
      def radio name, options = {}
        options = { :type => :radio, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options        
      end
      
      ##
      # Generates a file field.
      
      def file name, options = {}
        options = { :type => :file, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options        
      end
      
      ##
      # Generates a select field.
      
      def select name, options = {}, &block
        options = { :name => name, :value => "\n" }.merge options
        options[:value] << capture_elements(&block) if block_given?
        options[:value] << select_options(options) if options.include? :options
        tag :select, :attributes => options
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
        type = options.has_key?(:src) ? :image : :button
        options = { :type => type, :name => name }.merge options
        tag :input, :self_closing => true, :attributes => options
      end
      
      ##
      # Capture results of elements called within +block+. Optionally
      # a DataMapper model may be passed, at which point error classes
      # will be applied to invalid elements.
      
      def capture_elements model = nil, &block
        elements = yield Proxy.new model
        elements.join
      end
      
      private
      
      def select_options options
        options.delete(:options).collect { |value, title| option(value, title) }.join
      end
      
    end
  end
end