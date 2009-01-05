
describe DataMapper::Forms::Elements do
  
  include DataMapper::Forms::Elements
  
  it "should create generic tags" do
    tag(:textarea).should == "<textarea ></textarea>\n"
    tag(:input, :self_closing => true).should == "<input  />\n"
    tag(:input, :attributes => { :type => :textfield }, :self_closing => true).should == %(<input type="textfield" />\n)
  end
  
  it "should create textfields" do
    s = textfield :phone, :value => 'Enter phone number'
    s.should == %(<input type="textfield" name="phone" value="Enter phone number" />\n)
  end
  
  it "should create submit buttons" do
    s = submit :op, :value => 'Submit'
    s.should == %(<input type="submit" name="op" value="Submit" />\n)
  end
  
  it "should create buttons" do
    s = button :op, :value => 'Edit'
    s.should == %(<input type="button" name="op" value="Edit" />\n)    
  end
  
  it "should create labels" do
    s = label 'Email', :for => :email
    s.should == %(<label for="email">Email:</label>\n)
  end
  
  it "should create required labels" do
    s = label 'Email', :for => :email, :required => true
    s.should == %(<label for="email">Email:<em>*</em></label>\n)
  end
  
  it "should create textareas with labels" do
    s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
    s.should == <<-HTML.deindent
      <label for="comments">Comments</label>
      <textarea name="comments">Enter your comments here</textarea>
    HTML
  end
  
  it "should create textareas with labels which are required" do
    s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
    s.should == <<-HTML.deindent
      <label for="comments">Comments:<em>*</em></label>
      <textarea name="comments">Enter your comments here</textarea>
    HTML
  end
    
  it "should create forms defaulting to method of post" do
    s = form :register
    s.should == %(<form method="post"></form>\n)
  end
        
end