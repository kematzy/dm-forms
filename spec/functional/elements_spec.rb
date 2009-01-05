
include DataMapper::Forms::Elements

describe DataMapper::Forms::Elements do
  
  it "should attributeize a hash" do
    { 'foo' => 'bar' }.attributize.should == 'foo="bar"'
    { :type => :textfield, :value => 'Submit' }.attributize.should == 'type="textfield" value="Submit"'
  end
  
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
  
  it "should create textareas with labels" do
    s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
    s.should == <<-HTML
<label for="comments">Comments</label>
<textarea name="comments">Enter your comments here</textarea>
HTML
  end
  
  it "should create textareas with labels which are required" do
    s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments:', :required => true
    s.should == <<-HTML
<label for="comments">Comments: <em>*</em></label>
<textarea name="comments">Enter your comments here</textarea>
HTML
  end
  
end