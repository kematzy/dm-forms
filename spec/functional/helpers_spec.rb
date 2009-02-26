
def params
  Hash.new { |h, k| k }
end
public :params

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
        send(type, :name => 'foo').should have_tag("input[@type=#{type}]")
      end
    end
  end
  
  %w( textfield radio checkbox ).each do |type|
    describe "##{type}" do
      it "should use origin #params method to grab the default value when present" do
        send(type, :name => 'foo').should have_tag("input[@type=#{type}]") do |tag|
          tag.attributes['value'].should == 'foo'
        end
      end
    end
  end
  
  %w( textarea select ).each do |type|
    describe "##{type}" do
      it "should create an unbound #{type}" do
        send(type, :name => 'foo').should have_tag(type)
      end
    end
  end
  
  describe "#textarea" do
    it "should default its contents using origin #params" do
      textarea(:name => 'comments').should have_tag('textarea[@name=comments]', 'comments')
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
    
    it "should use multipart encoding when multipart is set" do
      markup = form :action => '/login', :multipart => true do
      end
      markup.should have_tag('form[@enctype=multipart/form-data]')
    end
    
    it "should use multipart encoding a file field is present" do
      markup = form :action => '/login' do
        file :name => 'image'
      end
      markup.should have_tag('form[@enctype=multipart/form-data]')
      markup.should_not have_tag('input[@type=hidden]')
    end
    
    it "should create a hidden input with _method when anything but get or post" do
      markup = form :method => :put do
        file :name => 'image'
      end
      markup.should have_tag('form[@method=post]')
      markup.should have_tag('input[@type=hidden]') do |input|
        input.attributes['name'].should == '_method'
        input.attributes['value'].should == 'put'
      end
    end
    
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
    it "should create a fieldset with optional legend" do
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
  
  describe "#submit" do
    it "should default value to Submit, and name to submit" do
      submit.should have_tag('input[@name=submit]')
      submit.should have_tag('input[@value=Submit]')
    end
  end
  
end