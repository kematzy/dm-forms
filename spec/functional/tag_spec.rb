
describe DataMapper::Form::Elements::Tag do
  
  Tag = DataMapper::Form::Elements::Tag
  
  it "should pull titles from :title, :legend, :caption, etc" do
    tag = Tag.new :input, :attributes => { :title => 'Comments' }
    tag.title.should == 'Comments'
    tag = Tag.new :input, :attributes => { :legend => 'Comments' }
    tag.title.should == 'Comments'
    tag = Tag.new :input, :attributes => { :caption => 'Comments' }
    tag.title.should == 'Comments'
  end
  
  it "should prepare and merge classes" do
    tag = Tag.new :input, :attributes => { :class => 'foo bar', :name => 'email', :type => :textfield }
    tag.send(:classes).should == 'foo bar form-textfield form-email'
  end
  
  it "should render titles" do
    tag = Tag.new :input, :attributes => { :title => 'Comments', :name => :comments }
    tag.render_title.should == %(<label for="comments">Comments:</label>\n) 
  end
  
  it "should render required titles" do
    tag = Tag.new :input, :attributes => { :label => 'Comments', :name => :comments, :required => true }
    tag.render_title.should == %(<label for="comments">Comments:<em>*</em></label>\n) 
  end
  
  it "should allow null titles" do
    lambda do
      tag = Tag.new :input, :attributes => { :name => :comments }
      tag.render_title
    end.should_not raise_error
  end
    
end