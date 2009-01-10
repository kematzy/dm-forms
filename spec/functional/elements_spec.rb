
include DataMapper::Form::Elements

describe DataMapper::Form::Elements do
  
  #--
  # Element aspecs
  #++

  describe "element aspecs" do
    
    it "should allow descriptions" do
      s = textarea :comments, :description => 'Please enter your comments.'
      s.should == <<-HTML.deindent
        <textarea class="form-textarea form-comments" name="comments"></textarea>
        <p class="description">Please enter your comments.</p>
      HTML
    end

    it "should allow prefixing of arbitrary markup" do
      s = textarea :comments, :before => "<h1>Comments</h1>\n"
      s.should == <<-HTML.deindent
        <h1>Comments</h1>
        <textarea class="form-textarea form-comments" name="comments"></textarea>
      HTML
    end

    it "should allow arbitrary markup after" do
      s = textarea :comments, :after => "\n<p>Custom markup</p>"
      s.should == <<-HTML.deindent
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
    
    it "should create textareas" do
      s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
      s.should == <<-HTML.deindent
        <label for="comments">Comments:</label>
        <textarea class="form-textarea form-comments" name="comments">Enter your comments here</textarea>
      HTML
    end
    
    it "should create fieldsets" do
      s = fieldset :details, :legend => 'Details', :value => 'WAHOO!'
      s.should == <<-HTML.deindent
        <fieldset class="fieldset-details">
        <legend>Details</legend>WAHOO!</fieldset>
      HTML
    end

    it "should create fieldsets with element capturing block" do
      s = fieldset :details, :id => 'details' do |f|
        f.button :one
        f.button :two
      end
      s.should == <<-HTML.deindent
        <fieldset class="fieldset-details" id="details">
        <legend>Details</legend><input type="button" class="form-button form-one" name="one" />
        <input type="button" class="form-button form-two" name="two" />
        </fieldset>
      HTML
    end

    it "should create fieldsets without legends, auto-generating them from the fieldset name" do
      s = fieldset :some_legend, :value => 'WAHOO!'
      s.should == <<-HTML.deindent
        <fieldset class="fieldset-some_legend">
        <legend>Some legend</legend>WAHOO!</fieldset>
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
      s.should == <<-HTML.deindent
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