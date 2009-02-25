
module DataMapper
  module Form
    module Helpers
      
      def new_form_context *args
        DataMapper::Form::Base.new *args
      end
      
      def form_context *args
        @__form_context ||= new_form_context *args
      end
      
      def with_form_context name, attrs = {}, &block
        new_form_context(name).instance_eval &block
      end
      
      def fields_for name, attrs = {}, &block 
        with_form_context name do
          capture &block
        end
      end
            
      %w( form fieldset ).each do |type|
        class_eval <<-EOF, __FILE__, __LINE__ + 1
          def #{type} *args, &block 
            form_context(nil, nil).#{type} *args, &block
          end
        EOF
      end
      
      %w( form_for fieldset_for ).each do |type|
        class_eval <<-EOF, __FILE__, __LINE__ + 1
          def #{type} name, attrs = {}, &block
            with_form_context name do
              #{type} attrs, &block
            end
          end
        EOF
      end
      
      %w( input checkbox button file textarea submit 
      hidden password radio select textfield ).each do |type|
        define_method type do |*args|
          meth = bound? *args ? "bound_#{type}" : "unbound_#{type}"
          form_context.send meth, *args
        end
      end
      
      private
      
      #:stopdoc:
      
      def bound? *args 
        args.first.is_a? Symbol
      end
      
      def capture &block
        @buffer = ''
        if block.arity > 0
          yield self
        else
          instance_eval &block
        end
        @buffer
      end
      
    end
  end
end
