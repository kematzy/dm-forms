
module DataMapper
  module Form
    class Tag
      
      ##
      # Boolean attributes.
      
      BOOLEAN_ATTRIBUTES = :disabled, :readonly, :multiple, :checked, :selected
      
      ##
      # Elements which should not include auto-generated classes.
      
      IGNORE_CLASSES_ON_ELEMENTS = :form, :label, :fieldset, :hidden
      
      ##
      # Name of element (input, fieldset, etc).
      
      attr_accessor :name
      
      ##
      # Options passed to the constructor.
      
      attr_accessor :options
      
      ##
      # Attributes pulled from #options.
      
      attr_accessor :attributes
      
      ##
      # Markup placed before the element.
      
      attr_accessor :before
      
      ##
      # Markup placed after the element.
      
      attr_accessor :after
      
      ##
      # Tag's description.
      
      attr_accessor :description
          
      def initialize name, options = {}, &block
        @name, @options, @attributes = name, options, (options[:attributes] ||= {})
        @before, @after = attribute(:before, ''), attribute(:after, '')
        @description = Elements.desc(attribute(:description)) || ''
        (@attributes[:value] ||= '') << Elements.capture_elements(attribute(:model), &block) if block_given?
      end
    
      ##
      # Render final markup of this element or 'tag'.
    
      def render
        @attributes[:class] = classes unless classes.blank?
        prepare_boolean_attributes
        before << label
        close = self_closing? ? " />" : ">#{inner_html}</#{@name}>"
        open = "<#{@name} #{@attributes.to_html_attributes}"
        tag = before << open << close << description << after << "\n"
      end
      alias :to_s :render
      
      ##
      # Prepare boolean attribute values, so that the user may
      # utilize :multiple => true, instead of :multiple => :multiple.
      
      def prepare_boolean_attributes
        @attributes.each_pair do |key, value|
          if BOOLEAN_ATTRIBUTES.include? key
            if value
              @attributes[key] = key
            else
              @attributes.delete key
            end
          end
        end
      end
    
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
      # Is the element required.
    
      def required?
        attribute :required, false
      end 
      
      ##
      # Generates a label when needed.
      
      def label
        @label ||= has_label? ? Elements.label(@attributes.delete(:label), :for => @attributes[:name], :required => required?) : ''
      end
      
      ##
      # Wither or not this tag has a label.
      
      def has_label?
        !@attributes[:label].blank?
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
        classes = "form-#{@name == :input ? @attributes[:type] : @name}"
        classes << " form-#{@attributes[:name]}" unless @attributes[:name].blank?
        classes
      end
    
      ##
      # Wither or not classes should be added to this element.
    
      def should_add_classes?
        !(IGNORE_CLASSES_ON_ELEMENTS.include? @name or IGNORE_CLASSES_ON_ELEMENTS.include? @attributes[:type])
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
