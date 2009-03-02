
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
    
    it "should mirror boolean attributes" do
      tag(:option, :selected => true).should have_tag("option[@selected=selected]")
      tag(:option, :selected => 'true').should have_tag("option[@selected=selected]")
      tag(:option, :selected => '1').should have_tag("option[@selected=selected]")
      tag(:option, :selected => 'selected').should have_tag("option[@selected=selected]")
    end
    
    it "should negate boolean attributes" do
      tag(:option, :selected => false).should have_tag("option:not([@selected=selected])")
      tag(:option, :selected => '').should have_tag("option:not([@selected=selected])")
      tag(:option, :selected => '0').should have_tag("option:not([@selected=selected])")
      tag(:option, :selected => 'false').should have_tag("option:not([@selected=selected])")
    end
  end
  
end