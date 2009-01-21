
include DataMapper::Form::Elements

describe DataMapper::Form::Elements do
  
  #--
  # Element aspecs
  #++

  describe "element aspecs" do
            
    it "should allow descriptions" do
      s = textarea :comments, :description => 'Please enter your comments.'
      s.should have_tag('p[@class="description"]', 'Please enter your comments.')
      s.should have_tag('textarea')
    end

    it "should allow prefixing of arbitrary markup" do
      s = textarea :comments, :before => "<h1>Comments</h1>\n"
      s.should have_tag('h1', 'Comments')
      s.should have_tag('textarea')
    end

    it "should allow arbitrary markup after" do
      s = textarea :comments, :after => "\n<p>Custom markup</p>"
      s.should have_tag('textarea')
      s.should have_tag('p', 'Custom markup')
    end
    
  end
    
  #--
  # Elements
  #++
  
  describe "elements" do
    
    it "should create labels" do
      s = label 'Email', :for => :email
      s.should have_tag('label[@for="email"]', 'Email:')
    end

    it "should create required labels" do
      s = label 'Email', :for => :email, :required => true
      s.should have_tag('label[@for="email"]') do |label|
        label.should have_tag('em', '*')
      end
    end
    
    it "should create textfields" do
      s = textfield :phone, :value => 'Enter phone number'
      s.should == %(<input type="textfield" class="form-textfield form-phone" value="Enter phone number" name="phone" />\n)
      s.should have_tag('input[@type="textfield"]')
    end

    it "should create submit buttons" do
      s = submit :op, :value => 'Submit'
      s.should have_tag('input[@type="submit"]')
    end

    it "should create buttons" do
      s = button :op, :value => 'Edit'
      s.should have_tag('input[@type="button"]')
    end
    
    it "should create image buttons" do
      s = button :op, :value => 'Edit', :src => 'path/to/image.png'
      s.should have_tag('input[@type="image"]')
    end
    
    it "should create a checkbox" do
      s = checkbox :agree_to_terms, :value => 'Agree to terms', :checked => true
      s.should have_tag('input[@type="checkbox"]') do |checkbox|
        checkbox[:checked].should == 'checked'
      end
    end
    
    it "should create a file field" do
      s = file :image
      s.should have_tag('input[@type="file"]')  
    end
    
    it "should create hidden fields" do
      s = hidden :_method, :value => 'put'
      s.should have_tag('input[@type="hidden"]')
    end
    
    it "should create a radio button" do
      s = radio :sex, :value => 'Male'
      s.should have_tag('input[@type="radio"]')
    end
    
    it "should create textareas" do
      s = textarea :comments, :value => 'Enter your comments here', :label => 'Comments'
      s.should have_tag('label')
      s.should have_tag('textarea[@name="comments"]', 'Enter your comments here')
    end
    
    it "should create fieldsets" do
      s = fieldset :details, :legend => 'Details', :value => 'WAHOO!'
      s.should have_tag('fieldset[@class="fieldset-details"]') do |fieldset|
        fieldset.should have_tag('legend', 'Details')
        fieldset.inner_html.should match(/WAHOO!/)
      end
    end

    it "should create fieldsets with element capturing block" do
      s = fieldset :details, :id => 'details' do |f|
        f.button :one
        f.button :two
      end
      s.should have_tag('fieldset[@class="fieldset-details"]') do |fieldset|
        fieldset.should have_tag('legend', 'Details')
        fieldset.should have_tag('input', :count => 2)
      end
    end

    it "should create fieldsets without legends, auto-generating them from the fieldset name" do
      s = fieldset :some_legend, :value => 'WAHOO!'
      s.should have_tag('fieldset[@class="fieldset-some_legend"]') do |fieldset|
        fieldset.should have_tag('legend', 'Some legend')
      end
    end
    
    it "should create select fields" do
      s = select :color, :options => { :red => 'Red', :green => 'Green', :blue => 'Blue' }
      s.should have_tag('select') do |select|
        select.should have_tag('option', :count => 3)
      end
    end
    
    it "should create select fields with block" do
      s = select :color do |s|
        s.option :red, 'Red'
        s.option :green, 'Green'
        s.option :blue, 'Blue'
      end
      s.should have_tag('select') do |select|
        select.should have_tag('option', :count => 3)
      end
    end
    
  end
  
  #--
  # Form specifics
  #++
  
  describe "forms" do
    
    it "should default method to post" do
      s = form :register
      s.should have_tag('form[@method="post"]')
    end

    it "should allow custom methods" do
      s = form :register, :method => :get
      s.should have_tag('form[@method="get"]')
    end

    it "should allow arbitrary inner html" do
      s = form :register, :method => :get, :value => 'COOKIE!'
      s.should have_tag('form', 'COOKIE!')
    end
    
    it "should store arbitrary methods in _method" do
      s = form :login, :method => :put do |f|
        f.submit :op, :value => 'Submit'
      end
      s.should have_tag('form[@method="post"]') do |form|
        form.should have_tag('input[@type="hidden"]') do |hidden|
          hidden[:name].should == '_method'
          hidden[:value].should == 'put'
        end
      end
    end
    
    it "should create with a block for inner html" do
      s = form :login do |f|
        f.textfield :name, :label => 'Username'
        f.textfield :pass, :label => 'Password'
        f.submit :op, :value => 'Login'
      end
      s.should have_tag('form') do |form|
        form.should have_tag('label', :count => 2)
        form.should have_tag('input', :count => 3)
      end
    end
    
  end
                  
end