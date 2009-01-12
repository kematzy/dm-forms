
describe DataMapper::Form::Tag do
  
  Tag = DataMapper::Form::Tag

  it "should generate classes" do
    tag = Tag.new :input, :attributes => { :name => 'email', :type => :textfield }
    tag.send(:classes).should == 'form-textfield form-email'    
  end

  it "should generate classes when no name is present" do
    tag = Tag.new :input, :attributes => { :type => :textfield }
    tag.send(:classes).should == 'form-textfield'    
  end
  
  it "should auto-assign boolean attributes" do
    tag = Tag.new :input, :attributes => { :name => 'email', :type => :textfield, :disabled => true }
    tag.render.should == %(<input type="textfield" class="form-textfield form-email" name="email" disabled="disabled"></input>\n)
  end
    
  it "should generate and merge classes" do
    tag = Tag.new :input, :attributes => { :class => 'foo bar', :name => 'email', :type => :textfield }
    tag.send(:classes).should == 'foo bar form-textfield form-email'
  end
  
  it "should grab inner html for non self-closing tags" do
    tag = Tag.new :textarea, :self_closing => false, :attributes => { :value => 'BOOYAH' }
    tag.inner_html.should == 'BOOYAH'
  end
  
  it "should allow descriptions and remove from attributes" do
    tag = Tag.new :input, :attributes => { :description => 'testing one two three' }
    tag.description.should == %(\n<p class="description">testing one two three</p>)  
    tag.attributes.has_key?(:description).should be_false  
  end
  
  it "should allow capturing of elements via block" do
    tag = Tag.new :fieldset, :attributes => { :id => 'something' } do |f|
      f.button :one
      f.button :two
    end
    tag.render.should == <<-HTML.deindent
      <fieldset id="something"><input type="button" class="form-button form-one" name="one" />
      <input type="button" class="form-button form-two" name="two" />
      </fieldset>
    HTML
  end
    
end