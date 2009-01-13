
module DataMapper
  module Form
    module ModelElements
      
      include Elements
      
      ##
      # Generates a form.
      
      def form_for model, options = {}, &block
        id = model.class.to_s.downcase
        method = model.new_record? ? :post : :put
        form id, :model => model, :method => method, :before => errors_for(model), &block
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