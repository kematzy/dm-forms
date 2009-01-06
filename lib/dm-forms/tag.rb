
module DataMapper
  module Form
    module Elements
      class Tag
      
        attr_accessor :name, :options
            
        def initialize name, options = {}
          @name, @options, @attributes = name, options, options[:attributes]
        end
      
        ##
        # Render final markup of this element or 'tag'.
      
        def render
          prepare_classes
          closure = self_closing? ? " />" : ">#{inner_html}</#{@name}>"
          tag = <<-HTML
#{before}
#{render_title}
<#{@name} #{@attributes.to_html_attributes}
#{closure}
#{description}
#{after}
HTML
          tag
        end
        alias :to_s :render
      
        ##
        # Wither or not a tag is self-closing (<br />).
      
        def self_closing?
          @options[:self_closing]
        end
      
        ##
        # The inner HTML of this tag, only available for
        # elements which are not self-closing.
      
        def inner_html
          attribute :value, '' unless self_closing?
        end
      
        ##
        # Attempt to pull title from :title, :label, :legend, etc.
      
        def title
          @title ||= [:title, :label, :legend, :caption].inject '' do |title, key|
            attribute key, ''
          end
        end
      
        ##
        # Render title for this element.
      
        def render_title
          Elements.label title, :for => @attributes[:name], :required => required? unless title.blank?
        end
            
        ##
        # Is the element required.
      
        def required?
          attribute :required, false
        end
      
        ##
        # Description for this attribute.
      
        def description
          desc = attribute :description, false
          Elements.desc desc if desc
        end
      
        ##
        # Markup before the element.
      
        def before
          attribute :before, ''
        end
      
        ##
        # Markup after the element.
      
        def after
          attribute :after, ''
        end
      
        private
      
        ##
        # Generate and merge classes.
      
        def prepare_classes
          @attributes[:class] ||= ''
          @attributes[:class] << " #{element_classes}"
        end
      
        ##
        # Generates element class(es) such as form-submit, etc.
      
        def element_classes
          if add_classes?
            suffix = @name == :input ? @attributes[:type] : @name
            "form-#{suffix} form-#{@attributes[:name]}"
          end
        end
      
        ##
        # Wither or not classes should be added to this element.
      
        def add_classes?
          ![:form, :label].include? @name
        end
      
        ##
        # Return an +attribute+ or its +default+ value.
      
        def attribute attribute, default = nil
          if attr = @attributes.delete(attribute)
            attr
          else
            default
          end   
        end
      
      end
    end
  end
end
