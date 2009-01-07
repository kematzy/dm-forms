
describe DataMapper::Form::Base do
  
  include DataMapper::Form::Elements
  
  it "should default method to post" do
    s = form :register
    s.should == %(<form method="post"></form>\n)
  end
  
  it "should allow custom methods" do
    s = form :register, :method => :get
    s.should == %(<form method="get"></form>\n)
  end
  
  it "should allow arbitrary inner html" do
    s = form :register, :method => :get, :value => 'COOKIE!'
    s.should == %(<form method="get">COOKIE!</form>\n)
  end
    
  it "should create forms with a block for inner html context" do
    s = form :login do 
      textfield :name, :title => 'Username'
      textfield :pass, :title => 'Password'
      submit :op, :title => 'Login'
    end
    p s
    s.should == <<-HTML.deindent
      <form method="post"><label for="op">Login:</label>
      <input type="submit" class="form-submit form-op" name="op" />
      </form>
    HTML
  end
  
end