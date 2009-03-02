
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
  
  describe "#textarea" do
    it "should default its contents using origin #params" do
      textarea(:name => 'comments').should have_tag('textarea[@name=comments]', 'comments')
    end
    
    it "should allow contents to be passed as a first argument" do
      def params; {} end
      textarea('Whatever', :name => 'comments').should have_tag('textarea[@name=comments]', 'Whatever')
    end
  end
  
  describe "#form" do
    it "should create a form, defaulting method to post" do
      markup = form :action => '/login' do
        textfield :name => 'name'
        textfield :name => 'pass'
        submit 'Login', :name => 'op'
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
        f.submit 'Login'
      end
      markup.should have_tag('form[@action=/login]') do |form|
        form.should have_tag('input[@name=name]')
        form.should have_tag('input[@name=pass]')
        form.should have_tag('input[@name=submit]')
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
    
    it "should allow the first arg to be a value string" do
      submit('Login').should have_tag('input[@value=Login]')
    end
  end
  
  describe "#select" do
    before :each do
      @days = {
        1 => 'Mon',
        2 => 'Tue',
        3 => 'Wed',
        4 => 'Thu',
        5 => 'Fri',
        6 => 'Sat',
        7 => 'Sun',
      }
    end
    
    it "should populate options" do
      select(:name => 'days', :options => @days).should have_tag('select[@name=days]') do |select|
        @days.each do |value, contents|
          select.should have_tag("option[@value=#{value}]", contents)
        end
      end
    end
    
    it "should allow setting of the selected option" do
      select(:name => 'days', :options => @days, :selected => 2).should have_tag('select[@name=days]') do |select|
        select.should have_tag('option[@value=2]') do |option|
          option.attributes['selected'].should == 'selected'
        end
        @days.each do |value, contents|
          select.should have_tag("option[@value=#{value}]", contents)
        end
      end      
    end
    
  end
  
end