
describe DataMapper::Form::Elements::Tag do
  
  Tag = DataMapper::Form::Elements::Tag
  
  it "should pull titles from :title, :legend, :caption, etc" do
    tag = Tag.new :input, :attributes => { :title => 'Comments' }
    tag.title.should == 'Comments'
  end
  
  it "should prepare and merge classes" do
    tag = Tag.new :input, :attributes => { :class => 'foo bar', :name => 'email', :type => :textfield }
    tag.send(:classes).should == 'foo bar form-textfield form-email'
  end
  
end