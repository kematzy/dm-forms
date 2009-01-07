
module DataMapper
  module Form
    module Elements 
      class Tag
        
        VALID_TITLE_KEYS = :title, :label, :legend, :caption
        IGNORE_CLASSES_ON_ELEMENTS = :form, :label
      
        attr_accessor :name, :options, :attributes, :before, :after, :description
            
        def initialize name, options = {}
          @name, @options, @attributes = name, options, options[:attributes]
          @before, @after = attribute(:before, ''), attribute(:after, '')
          @description = Elements.desc(attribute(:description)) || ''
        end
      
        ##
        # Render final markup of this element or 'tag'.
      
        def render
          @attributes[:class] = classes unless classes.blank?
          title = render_title
          close = self_closing? ? " />" : ">#{inner_html}</#{@name}>"
          open = "<#{@name} #{@attributes.to_html_attributes}"
          tag = before << title << open << close << description << after << "\n"
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
          @title ||= attribute title_key
        end
        
        ##
        # Attempt to find and return valid title key or ''.
        
        def title_key
          VALID_TITLE_KEYS.find { |key| @attributes.has_key? key }
        end
      
        ##
        # Render title for this element.
      
        def render_title
          if title.blank?
            ''
          else
            Elements.label title, :for => @attributes[:name], :required => required?
          end
        end
            
        ##
        # Is the element required.
      
        def required?
          attribute :required, false
        end

        ##
        # Returns user generated classes as well as those generated by
        # dm-forms for styling consistancy.
      
        def classes
          @classes ||= [@attributes[:class], generate_classes].join(' ').strip if should_add_classes?
        end
              
        private
        
        ##
        # Generates element class(es) such as form-submit.
                
        def generate_classes
          suffix = @name == :input ? @attributes[:type] : @name
          "form-#{suffix} form-#{@attributes[:name]}"
        end
      
        ##
        # Wither or not classes should be added to this element.
      
        def should_add_classes?
          !IGNORE_CLASSES_ON_ELEMENTS.include? @name
        end
      
        ##
        # Return an +attribute+ or its +default+ value, removing
        # it from @attributes so that final attributes rendered
        # within the HTML are not cluttered with ad-hoc keys.
      
        def attribute attribute, default = nil
          @attributes.delete(attribute) || default 
        end
      
      end
    end
  end
end
