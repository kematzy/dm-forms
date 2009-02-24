
describe DataMapper::Form::Tag do
  
  include DataMapper::Form::Tag
  
  describe "#tag" do
    it "should create a simple tag" do
      tag(:div).should have_tag('div')
    end
    
    it "should create a tag with attributes" do
      tag(:div, :id => 'foo').should have_tag('div#foo')
    end

    it "should create a tag with param contents" do
      tag(:div, 'bar', :id => 'foo').should have_tag('div#foo', 'bar')
    end
    
    it "should create a tag with block contents" do
      tag :div, :id => 'foo' do
        'bar'
      end.
      should have_tag('div#foo', 'bar')
    end
  end
  
end