
describe DataMapper::Form::Helpers do
  
  include DataMapper::Form::Helpers
  
  describe "#new_form_context" do
    it "should create a new context each time its called" do
      a = new_form_context
      b = new_form_context
      a.should be_a(DataMapper::Form::Base)
      b.should be_a(DataMapper::Form::Base)
      a.should_not == b
    end
  end 
  
  describe "#form_context" do
    it "should utilize the previous context or create a new one when not present" do
      a = form_context
      b = form_context
      a.should be_a(DataMapper::Form::Base)
      b.should be_a(DataMapper::Form::Base)
      a.should == b
    end
  end
  
  %w( textfield submit file button hidden password radio checkbox ).each do |type|
    describe "##{type}" do
      it "should create an unbound #{type}" do
        send(type, :id => 'foo').should have_tag("input[@type=#{type}]") do |tag|
          tag.attributes['id'].should == 'foo'
        end
      end
    end
  end
  
  %w( textarea select ).each do |type|
    describe "##{type}" do
      it "should create an unbound #{type}" do
        send(type, :id => 'foo').should have_tag(type) do |tag|
          tag.attributes['id'].should == 'foo'
        end
      end
    end
  end
  
  describe "#form" do
    it "should create a form, defaulting method to post" do
      markup = form :action => '/login' do
        textfield :name => 'name'
        textfield :name => 'pass'
        submit :name => 'op', :value => 'Login'
      end
      markup.should have_tag('form[@action=/login]') do |form|
        form.attributes['method'].should == 'post'
        form.should have_tag('input[@name=name]')
        form.should have_tag('input[@name=pass]')
        form.should have_tag('input[@name=op]')
      end
    end
    
    it "should create a form with get method" do
      markup = form :action => '/login', :method => :get do
      end
      markup.should have_tag('form[@method=get]')
    end
  end
  
  describe "#form" do
    it "should create a form using yeild syntax" do
      markup = form :action => '/login' do |f|
        f.textfield :name => 'name'
        f.textfield :name => 'pass'
        f.submit :name => 'op', :value => 'Login'
      end
      markup.should have_tag('form[@action=/login]') do |form|
        form.should have_tag('input[@name=name]')
        form.should have_tag('input[@name=pass]')
        form.should have_tag('input[@name=op]')
      end
    end
  end
  
  describe "#fieldset" do
    it "should a fieldset with optional legend" do
      markup = fieldset :legend => 'User Details' do
        textfield :name => 'name'
        textfield :name => 'email'
      end
      markup.should have_tag('fieldset') do |fieldset|
        fieldset.should have_tag('legend', 'User Details')
        fieldset.should have_tag('input[@name=name]')
        fieldset.should have_tag('input[@name=email]')
      end
    end
  end
    
end