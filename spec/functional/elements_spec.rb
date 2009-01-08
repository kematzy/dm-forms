
describe DataMapper::Form::Elements do
  
  include DataMapper::Form::Elements

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
  
  it "should create labels" do
    s = label 'Email', :for => :email
    s.should == %(<label for="email">Email:</label>\n)
  end
  
  it "should create required labels" do
    s = label 'Email', :for => :email, :required => true
    s.should == %(<label for="email">Email:<em>*</em></label>\n)
  end
  
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
      
  it "should create textareas with labels" do
    s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
    s.should == <<-HTML.deindent
      <label for="comments">Comments:</label>
      <textarea class="form-textarea form-comments" name="comments">Enter your comments here</textarea>
    HTML
  end
  
  it "should create textareas with labels using :title for unification" do
    s = textarea :comments, :title => 'Comments'
    s.should == <<-HTML.deindent
      <label for="comments">Comments:</label>
      <textarea class="form-textarea form-comments" name="comments"></textarea>
    HTML
  end
    
  it "should create textareas with labels which are required" do
    s = textarea :comments, :label => 'Comments', :required => true
    s.should == <<-HTML.deindent
      <label for="comments">Comments:<em>*</em></label>
      <textarea class="form-textarea form-comments" name="comments"></textarea>
    HTML
  end
  
  it "should create fieldsets with arbitrary inner html" do
    s = fieldset :details, :legend => 'Details', :value => 'WAHOO!'
    s.should == <<-HTML.deindent
      <fieldset class="fieldset-details form-fieldset"><legend>Details</legend>WAHOO!</fieldset>
    HTML
  end
                
end