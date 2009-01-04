
include DataMapper::Forms::Elements

describe DataMapper::Forms::Elements do
  
  it "should attributeize a hash" do
    { 'foo' => 'bar' }.attributeize.should == 'foo="bar"'
    { :type => :textfield, :value => 'Submit' }.attributeize.should == 'type="textfield" value="Submit"'
  end
  
  it "should create generic tags" do
    tag(:input, :attributes => { :type => :textfield }).should == '<input type="textfield" />'
  end
  
end