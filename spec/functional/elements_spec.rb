
include DataMapper::Forms::Elements

describe DataMapper::Forms::Elements do
  
  it "should attributeize a hash" do
    { 'foo' => 'bar' }.attributize.should == 'foo="bar"'
    { :type => :textfield, :value => 'Submit' }.attributize.should == 'type="textfield" value="Submit"'
  end
  
  it "should create generic tags" do
    tag(:textarea).should == '<textarea  /></textarea>'
    tag(:input, :self_closing => true).should == '<input  />'
    tag(:input, :attributes => { :type => :textfield }, :self_closing => true).should == '<input type="textfield" />'
  end
  
  it "should create textfields" do
    s = textfield :name => :phone, :value => 'Enter phone number'
    s.should == '<intput type="textfield" value="Enter phone number" />'
  end
  
end