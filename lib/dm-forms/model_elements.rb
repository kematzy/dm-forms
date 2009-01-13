
module DataMapper
  module Form
    module ModelElements
      
      include Elements
      
      ##
      # Generates a form.
      
      def form_for model, options = {}, &block
        id = model.class.to_s.downcase
        method = model.new_record? ? :post : :put
        # options = { :method => method, :id => "form-#{model.class.to_s.downcase}", :before => errors_for(model) }.merge options
        # tag :form, :attributes => options, :model => model, &block
        form id, :method => method, :before => errors_for(model)
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
      
    end
  end
end