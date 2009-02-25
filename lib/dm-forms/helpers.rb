
module DataMapper
  module Form
    module Helpers
      
 
      
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
