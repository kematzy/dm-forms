
module DataMapper
  module Form
    module Helpers
      
      def fields_for model, attrs = {}, &block 
        with_form_context model do
          capture &block
        end
      end
            
      %w( form fieldset ).each do |type|
        class_eval <<-EOF, __FILE__, __LINE__ + 1
          def #{type} *args, &block
            form_context(nil, self).#{type} *args, &block
          end
        EOF
      end
      
      %w( form_for fieldset_for ).each do |type|
        class_eval <<-EOF, __FILE__, __LINE__ + 1
          def #{type} model, attrs = {}, &block
            with_form_context model do
              #{type.sub(/_for/, '')} attrs, &block
            end
          end
        EOF
      end
      
      %w( checkbox button file textarea submit 
      hidden password radio select textfield ).each do |type|
        define_method type do |*args|
          method = bound?(*args) ? :"bound_#{type}" : :"unbound_#{type}"
          form_context(nil, self).send method, *args
        end
      end
      
      #:nodoc:
      
      def new_form_context *args
        Base.new *args
      end
      
      def form_context *args
        @__form_context ||= new_form_context *args
      end
      
      def with_form_context model, attrs = {}, &block
        @__form_context = nil
        form_context(model, self).instance_eval &block
      end
      
      def bound? *args 
        args.first.is_a? Symbol
      end
      
      def buffer string = nil
        @buffer ||= ''
      end
      
      def capture &block
        if block.arity > 0
          yield self
        else
          instance_eval &block
        end
        buffer
      end
      
    end
  end
end
