
module DataMapper
  module Form
    module Tag
      
      #--
      # Borrowed / adapted from Merb
      #++
      
      BOOL_ATTRIBUTES = :selected, :checked, :multiple
      
      ##
      # Creates a generic tag. You can invoke it a variety of ways.
      #   
      #   tag :div
      #   # <div></div>
      #   
      #   tag :div, 'content'
      #   # <div>content</div>
      #   
      #   tag :div, :class => 'class'
      #   # <div class="class"></div>
      #   
      #   tag :div, 'content', :class => 'class'
      #   # <div class="class">content</div>
      #   
      #   tag :div do
      #     'content'
      #   end
      #   # <div>content</div>
      #   
      #   tag :div, :class => 'class' do
      #     'content'
      #   end
      #   # <div class="class">content</div>
      # 
      
      def tag name, contents = nil, attrs = {}, &block
        attrs, contents = contents, nil if contents.is_a? Hash 
        contents = yield if block_given?
        open_tag(name, attrs) + contents.to_s + close_tag(name)
      end
    
      ##
      # Creates the opening tag with attributes for the provided +name+
      # attrs is a hash where all members will be mapped to key="value"
      #
      # Note: This tag will need to be closed
      
      def open_tag name, attrs = {}
        "<#{name}#{optional_attrs(attrs)}>"
      end
    
      ##
      # Creates a closing tag
      
      def close_tag name 
        "</#{name}>\n"
      end
    
      ##
      # Creates a self closing tag.  Like <br/> or <img src="..."/>
      #
      # +name+ : the name of the tag to create
      # +attrs+ : a hash where all members will be mapped to key="value"
      
      def self_closing_tag name, attrs = {}
        "<#{name}#{optional_attrs(attrs)}/>\n"
      end
      
      private
      
      #:stopdoc:
      
      def optional_attrs attrs = {}
        ' ' + boolean_attrs(attrs).to_html_attributes unless attrs.blank?
      end
      
      def boolean_attrs attrs = {}
        attrs.each do |key, value|
          if key.in? BOOL_ATTRIBUTES
            value.to_bool ? attrs[key] = key : attrs.delete(key)
          end
        end
      end
      
    end
  end
end