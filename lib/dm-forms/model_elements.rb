
module DataMapper
  module Form
    module ModelElements
      
      include Elements
      
      ##
      # Generates a form.
      
      def form_for model, options = {}, &block
        options = { :method => :post, :id => "form-#{model_name(model)}", :before => errors_for(model) }.merge options
        tag :form, :attributes => options, :model => model, &block
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
      
      private
      
      def model_name model #:nodoc:
        model.class.to_s.downcase
      end
      
    end
  end
end