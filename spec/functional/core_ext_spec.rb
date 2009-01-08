
describe "#humanize" do
  
  it "should humanize strings" do
    'im_a_Lame_String.Yeah.with.7.words'.humanize.should == 'im a Lame String Yeah with 7 words'
  end
  
  it "should humanize symbols" do
    :some_Cool_symbol.humanize.should == 'some Cool symbol'
  end
  
end