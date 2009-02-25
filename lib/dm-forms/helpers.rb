
module DataMapper
  module Form
    module Helpers
      
      #--
      # Borrowed / adapted from Merb
      #++
      
      def new_form_context
        Builder::Base.new
      end
      
      # TODO: private?

      def contexts
        @__contexts ||= []
      end
      
      def current_context
        contexts.last
      end

      def with_context name, &block
        form_contexts.push new_form_context
        ret = yield
        contexts.pop
        ret
      end

      ##
      # Generates a form tag, which accepts a block that is not directly based on resource attributes
      #
      # ==== Parameters
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Notes
      #  * Block helpers use the <%= =%> syntax
      #  * a multipart enctype is automatically set if the form contains a file upload field
      #
      # ==== Example
      #   <%= form :action => url(:controller => "foo", :action => "bar", :id => 1) do %>
      #     <%= text_field :name => "first_name", :label => "First Name" %>
      #     <%= submit "Create" %>
      #   <% end =%>
      #
      #   Generates the HTML:
      #
      #   <form action="/foo/bar/1" method="post">
      #     <label for="first_name">First Name</label>
      #     <input type="text" id="first_name" name="first_name" />
      #     <input type="submit" value="Create" />
      #   </form>
      #
      
      def form *args, &block 
        new_form_context.form *args, &block
      end

      ##
      # Generates a resource specific form tag which accepts a block, this also provides automatic resource routing.
      #
      # ==== Parameters
      # name<Symbol>:: Model or Resource
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Notes
      #  * Block helpers use the <%= =%> syntax
      #
      # ==== Example
      #   <%= form_for @person do %>
      #     <%= text_field :first_name, :label => "First Name" %>
      #     <%= text_field :last_name,  :label => "Last Name" %>
      #     <%= submit "Create" %>
      #   <% end =%>
      #
      # The HTML generated for this would be:
      #
      #   <form action="/people" method="post">
      #     <label for="person_first_name">First Name</label>
      #     <input type="text" id="person_first_name" name="person[first_name]" />
      #     <label for="person_last_name">Last Name</label>
      #     <input type="text" id="person_last_name" name="person[last_name]" />
      #     <input type="submit" value="Create" />
      #   </form>
      #
      
      def form_for name, attrs = {}, &block 
        with_form_context name do
          current_context.form attrs, &block 
        end
      end
  
      ##
      # Creates a scope around a specific resource object like form_for, but doesnt create the form tags themselves.
      # This makes fields_for suitable for specifying additional resource objects in the same form. 
      #
      # ==== Examples
      #   <%= form_for @person do %>
      #     <%= text_field :first_name, :label => "First Name" %>
      #     <%= text_field :last_name,  :label => "Last Name" %>
      #     <%= fields_for @permission do %>
      #       <%= check_box :is_admin, :label => "Administrator" %>
      #     <% end =%>
      #     <%= submit "Create" %>
      #   <% end =%>
      #
      
      def fields_for name, &block 
        with_form_context name do
          capture &block
        end
      end
      
      ##
      # Provides the ability to create quick fieldsets as blocks for your forms.
      #
      # ==== Parameters
      # attrs<Hash>:: HTML attributes and options
      #
      # ==== Options
      # +legend+:: Adds a legend tag within the fieldset
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Notes
      # Block helpers use the <%= =%> syntax
      #
      # ==== Example
      #   <%= fieldset :legend => "Customer Options" do %>
      #     ...your form elements
      #   <% end =%>
      #
      # Generates the HTML:
      #
      #   <fieldset>
      #     <legend>Customer Options</legend>
      #     ...your form elements
      #   </fieldset>
      #
      
      def fieldset attrs = {}, &block
        new_form_context.fieldset attrs, &block 
      end

      def fieldset_for name, attrs = {}, &block 
        with_form_context name do
          current_context.fieldset attrs, &block
        end
      end

      ##
      # Provides a generic HTML checkbox input tag.
      # There are two ways this tag can be generated, based on the
      # option :boolean. If not set to true, a "magic" input is generated.
      # Otherwise, an input is created that can be easily used for passing
      # an array of values to the application.
      #
      # ==== Parameters
      # method<Symbol>:: Resource attribute
      # attrs<Hash>:: HTML attributes and options
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= check_box :name => "is_activated", :value => "1" %>
      #   <%= check_box :name => "choices[]", :boolean => false, :value => "dog" %>
      #   <%= check_box :name => "choices[]", :boolean => false, :value => "cat" %>
      #   <%= check_box :name => "choices[]", :boolean => false, :value => "weasle" %>
      #
      # Used with a model:
      #
      #   <%= check_box :is_activated, :label => "Activated?" %>
      #
      
      def check_box; end

      ##
      # Provides a HTML file input
      #
      # ==== Parameters
      # name<Symbol>:: Model or Resource
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= file_field :name => "file", :label => "File" %>
      #
      # Used with a model:
      #
      #   <%= file_field :file, :label => "Choose a file" %>
      #
      
      def file_field; end

      ##
      # Provides a HTML hidden input field
      #
      # ==== Parameters
      # name<Symbol>:: Model or Resource
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= hidden_field :name => "secret", :value => "some secret value" %>
      #
      # Used with a model:
      #
      #   <%= hidden_field :identifier %>
      #   # => <input type="hidden" id="person_identifier" name="person[identifier]" value="#{@person.identifier}" />
      #
      
      def hidden_field; end

      ##
      # Provides a generic HTML label.
      #
      # ==== Parameters
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= label "Full Name", :for => "name" %> 
      #   => <label for="name">Full Name</label>
      #
      
      def label *args 
        current_form_context.label(*args)
      end
      
      ##
      # Provides a HTML password input.
      #
      # ==== Parameters
      # name<Symbol>:: Model or Resource
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= password_field :name => :password, :label => "Password" %>
      #   # => <label for="password">Password</label><input type="password" id="password" name="password" />
      #
      # Used with a model:
      #
      #   <%= password_field :password, :label => 'New Password' %>
      #
      
      def password_field; end

      ##
      # Provides a HTML radio input tag
      #
      # ==== Parameters
      # method<Symbol>:: Resource attribute
      # attrs<Hash>:: HTML attributes and options
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= radio_button :name => "radio_options", :value => "1", :label => "One" %>
      #   <%= radio_button :name => "radio_options", :value => "2", :label => "Two" %>
      #   <%= radio_button :name => "radio_options", :value => "3", :label => "Three", :checked => true %>
      #
      # Used with a model:
      #
      #   <%= form_for @person do %>
      #     <%= radio_button :first_name %>
      #   <% end =%>
      #
      
      def radio_button; end

      ##
      # Provides a radio group based on a resource attribute.
      # This is generally used within a resource block such as +form_for+.
      #
      # ==== Parameters
      # method<Symbol>:: Resource attribute
      # arr<Array>:: Choices
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Examples
      #   <%# the labels are the options %>
      #   <%= radio_group :my_choice, [5,6,7] %>
      #
      #   <%# custom labels %>
      #   <%= radio_group :my_choice, [{:value => 5, :label => "five"}] %>
      #
      
      def radio_group; end

      ##
      # Provides a HTML select
      #
      # ==== Parameters
      # method<Symbol>:: Resource attribute
      # attrs<Hash>:: HTML attributes and options
      #
      # ==== Options
      # +prompt+:: Adds an additional option tag with the provided string with no value.
      # +selected+:: The value of a selected object, which may be either a string or an array.
      # +include_blank+:: Adds an additional blank option tag with no value.
      # +collection+:: The collection for the select options
      # +text_method+:: Method to determine text of an option (as a symbol). Ex: :text_method => :name  will call .name on your record object for what text to display.
      # +value_method+:: Method to determine value of an option (as a symbol).
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= select :name, :collection => %w(one two three) %>
      #
      
      def select; end

      ##
      # Provides a HTML textarea tag
      #
      # ==== Parameters
      # contents<String>:: Contents of the text area
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= text_area "my comments", :name => "comments" %>
      #
      # Used with a model:
      #
      #   <%= text_area :comments %>
      #
      
      def text_area; end

      ##
      # Provides a HTML text input tag
      #
      # ==== Parameters
      # name<Symbol>:: Model or Resource
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= text_field :name => :fav_color, :label => "Your Favorite Color" %>
      #   # => <label for="fav_color">Your Favorite Color</label><input type="text" id="fav_color" name="fav_color" />
      #
      # Used with a model:
      #
      #   <%= form_for @person do %>
      #     <%= text_field :first_name, :label => "First Name" %>
      #   <% end =%>
      #
      
      def text_field; end
      
      # TODO: better means of metaprogramming unbound versions
      # TODO: pull them into this... not Base

      # @todo radio_group helper still needs to be implemented
      %w(text_field password_field hidden_field file_field
      text_area select check_box radio_button radio_group).each do |kind|
        self.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{kind}(*args)
            if bound?(*args)
              current_context.bound_#{kind}(*args)
            else
              current_context.unbound_#{kind}(*args)
            end
          end
        RUBY
      end

      ##
      # Generates a HTML button.
      #
      # ==== Parameters
      # contents<String>:: HTML contained within the button tag
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Notes
      #  * Buttons do not always work as planned in IE
      #    http://www.peterbe.com/plog/button-tag-in-IE
      #  * Not all mobile browsers support buttons
      #    http://nickcowie.com/2007/time-to-stop-using-the-button-element/
      #
      # ==== Example
      #   <%= button "Initiate Launch Sequence" %>
      #
      
      def button contents, attrs = {} 
        current_form_context.button contents, attrs 
      end
  
      ##
      # Generates a HTML delete button.
      #
      # If an object is passed as first parameter, Merb will try to use the resource url for the object
      # If the object doesn't have a resource view, pass a url
      #
      # ==== Parameters
      # object_or_url<Object> or <String>:: Object to delete or URL to send the request to
      # contents<String>:: HTML contained within the button tag
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= delete_button @article, "Delete article now", :class => 'delete-btn' %>
      #   <%= delete_button url(:article, @article)%>
      #
      
      def delete_button object_or_url, contents="Delete", attrs = {}
        # TODO: alter ... since we do not work with mvc route mapping
        url = object_or_url.is_a?(String) ? object_or_url : resource(object_or_url)
        button_text = (contents || 'Delete')
        tag :form, :class => 'delete-btn', :action => url, :method => :post do
          tag(:input, :type => :hidden, :name => "_method", :value => "DELETE") <<
          tag(:input, attrs.merge(:value => button_text, :type => :submit))
        end
      end

      ##
      # Generates a HTML submit button.
      #
      # ==== Parameters
      # value<String>:: Sets the value="" attribute
      # attrs<Hash>:: HTML attributes
      #
      # ==== Returns
      # String:: HTML
      #
      # ==== Example
      #   <%= submit "Process" %>
      #
      
      def submit contents, attrs = {} 
        current_form_context.submit(contents, attrs)
      end

      private
      
      #:stopdoc:
      
      def capture &block
        if block.arity > 0
          yield self
        else
          instance_eval &block
        end
      end
      
      def bound? *args 
        args.first.is_a? Symbol
      end
      
    end
  end
end
