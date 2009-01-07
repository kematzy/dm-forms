
describe DataMapper::Form::Base do
  
  include DataMapper::Form::Elements
  
  it "should default method to post" do
    s = form :register
    s.should == %(<form method="post" id="form-register"></form>\n)
  end
  
  it "should allow custom methods" do
    s = form :register, :method => :get
    s.should == %(<form method="get" id="form-register"></form>\n)
  end
  
  it "should allow arbitrary inner html" do
    s = form :register, :method => :get, :value => 'COOKIE!'
    s.should == %(<form method="get" id="form-register">COOKIE!</form>\n)
  end
    
  it "should create forms with a block for inner html context" do
    s = form :login do 
      textfield :name, :title => 'Username'
      textfield :pass, :title => 'Password'
      submit :op, :value => 'Login'
    end
    s.should == <<-HTML.deindent
      <form method="post" id="form-login"><label for="name">Username:</label>
      <input type="textfield" class="form-textfield form-name" name="name" />
      <label for="pass">Password:</label>
      <input type="textfield" class="form-textfield form-pass" name="pass" />
      <input type="submit" class="form-submit form-op" value="Login" name="op" />
      </form>
    HTML
  end
  
end