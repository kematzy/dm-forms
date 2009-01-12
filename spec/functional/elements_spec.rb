
include DataMapper::Form::Elements

describe DataMapper::Form::Elements do
  
  #--
  # Element aspecs
  #++

  describe "element aspecs" do
            
    it "should allow descriptions" do
      s = textarea :comments, :description => 'Please enter your comments.'
      s.should == <<-HTML.deindent(8)
        <textarea class="form-textarea form-comments" name="comments"></textarea>
        <p class="description">Please enter your comments.</p>
      HTML
    end

    it "should allow prefixing of arbitrary markup" do
      s = textarea :comments, :before => "<h1>Comments</h1>\n"
      s.should == <<-HTML.deindent(8)
        <h1>Comments</h1>
        <textarea class="form-textarea form-comments" name="comments"></textarea>
      HTML
    end

    it "should allow arbitrary markup after" do
      s = textarea :comments, :after => "\n<p>Custom markup</p>"
      s.should == <<-HTML.deindent(8)
        <textarea class="form-textarea form-comments" name="comments"></textarea>
        <p>Custom markup</p>
      HTML
    end
    
  end
    
  #--
  # Elements
  #++
  
  describe "elements" do
    
    it "should create labels" do
      s = label 'Email', :for => :email
      s.should == %(<label for="email">Email:</label>\n)
    end

    it "should create required labels" do
      s = label 'Email', :for => :email, :required => true
      s.should == %(<label for="email">Email:<em>*</em></label>\n)
    end
    
    it "should create textfields" do
      s = textfield :phone, :value => 'Enter phone number'
      s.should == %(<input type="textfield" class="form-textfield form-phone" value="Enter phone number" name="phone" />\n)
    end

    it "should create submit buttons" do
      s = submit :op, :value => 'Submit'
      s.should == %(<input type="submit" class="form-submit form-op" value="Submit" name="op" />\n)
    end

    it "should create buttons" do
      s = button :op, :value => 'Edit'
      s.should == %(<input type="button" class="form-button form-op" value="Edit" name="op" />\n)    
    end
    
    it "should create image buttons" do
      s = button :op, :value => 'Edit', :src => 'path/to/image.png'
      s.should == %(<input type="image" class="form-image form-op" value="Edit" name="op" src="path/to/image.png" />\n)    
    end
    
    it "should create a checkbox" do
      s = checkbox :agree_to_terms, :value => 'Agree to terms', :checked => true
      s.should == %(<input type="checkbox" class="form-checkbox form-agree_to_terms" value="Agree to terms" checked="checked" name="agree_to_terms" />\n)    
    end
    
    it "should create a file field" do
      s = file :image
      s.should == %(<input type="file" class="form-file form-image" name="image" />\n)    
    end
    
    it "should create a radio button" do
      s = radio :sex, :value => 'Male'
      s.should == %(<input type="radio" class="form-radio form-sex" value="Male" name="sex" />\n)
    end
    
    it "should create textareas" do
      s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
      s.should == <<-HTML.deindent(8)
        <label for="comments">Comments:</label>
        <textarea class="form-textarea form-comments" name="comments">Enter your comments here</textarea>
      HTML
    end
    
    it "should create fieldsets" do
      s = fieldset :details, :legend => 'Details', :value => 'WAHOO!'
      s.should == <<-HTML.deindent(8)
        <fieldset class="fieldset-details">
        <legend>Details</legend>WAHOO!</fieldset>
      HTML
    end

    it "should create fieldsets with element capturing block" do
      s = fieldset :details, :id => 'details' do |f|
        f.button :one
        f.button :two
      end
      s.should == <<-HTML.deindent(8)
        <fieldset class="fieldset-details" id="details">
        <legend>Details</legend><input type="button" class="form-button form-one" name="one" />
        <input type="button" class="form-button form-two" name="two" />
        </fieldset>
      HTML
    end

    it "should create fieldsets without legends, auto-generating them from the fieldset name" do
      s = fieldset :some_legend, :value => 'WAHOO!'
      s.should == <<-HTML.deindent(8)
        <fieldset class="fieldset-some_legend">
        <legend>Some legend</legend>WAHOO!</fieldset>
      HTML
    end
    
    it "should create select fields" do
      s = select :color, :options => { :red => 'Red', :green => 'Green', :blue => 'Blue' }
      s.should == <<-HTML.deindent(8)
        <select class="form-select form-color" name="color">
        <option value="blue">Blue</option>
        <option value="red">Red</option>
        <option value="green">Green</option>
        </select>
      HTML
    end
    
    it "should create select fields with block" do
      s = select :color do |s|
        s.option :red, 'Red'
        s.option :green, 'Green'
        s.option :blue, 'Blue'
      end
      s.should == <<-HTML.deindent(8)
        <select class="form-select form-color" name="color">
        <option value="red">Red</option>
        <option value="green">Green</option>
        <option value="blue">Blue</option>
        </select>
      HTML
    end
    
  end
  
  #--
  # Form specifics
  #++
  
  describe "forms" do
    
    it "should default method to post" do
      s = form :register
      s.should == %(<form method="post" id="form-register"></form>\n)
    end

    it "should allow custom methods" do
      s = form :register, :method => :get
      s.should == %(<form method="get" id="form-register"></form>\n)
    end

    it "should allow arbitrary inner html" do
      s = form :register, :method => :get, :value => 'COOKIE!'
      s.should == %(<form method="get" id="form-register">COOKIE!</form>\n)
    end

    it "should create with a block for inner html" do
      s = form :login do |f|
        f.textfield :name, :label => 'Username'
        f.textfield :pass, :label => 'Password'
        f.submit :op, :value => 'Login'
      end
      s.should == <<-HTML.deindent(8)
        <form method="post" id="form-login"><label for="name">Username:</label>
        <input type="textfield" class="form-textfield form-name" name="name" />
        <label for="pass">Password:</label>
        <input type="textfield" class="form-textfield form-pass" name="pass" />
        <input type="submit" class="form-submit form-op" value="Login" name="op" />
        </form>
      HTML
    end
    
  end
                  
end