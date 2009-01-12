
module DataMapper
  module Form
    module ModelElements
      include Elements
      
      ##
      # Generates a form.
      
      def form_for name, options = {}, &block
        options = { :method => :post, :id => "form-#{name}" }.merge options
        tag :form, :attributes => options, &block
      end
      
      ##
      # Return markup for errors on +model+.
      
      def errors_for model
        unless model.all_valid?
          s = %(<ul class="messages error">\n)
          s << model.errors.collect { |error| "<li>#{error.first}</li>" }.join("\n") 
          s << "\n</ul>\n"
        end
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
      
    end
  end
end