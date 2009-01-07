
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
  
  it "should generate classes" do
    tag = Tag.new :input, :attributes => { :name => 'email', :type => :textfield }
    tag.send(:classes).should == 'form-textfield form-email'    
  end
  
  it "should generate and merge classes" do
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
  
  it "should grab inner html for non self-closing tags" do
    tag = Tag.new :textarea, :self_closing => false, :attributes => { :value => 'BOOYAH' }
    tag.inner_html.should == 'BOOYAH'
  end
  
  it "should allow descriptions and remove from attributes" do
    tag = Tag.new :input, :attributes => { :description => 'testing one two three' }
    tag.description.should == %(\n<p class=\"description\">testing one two three</p>)  
    tag.attributes.has_key?(:description).should be_false  
  end
    
end