
module DataMapper
  module Forms
    module Elements
      def tag name, options = {}
        self_closing = options[:self_closing]
        value = options[:attributes].delete(:value) if self_closing rescue ''
        s = "<#{name} #{options[:attributes].attributize}"
        s << if self_closing
            " />"
          else
            " />#{value}</#{name}>"
          end
      end
    end
  end
end