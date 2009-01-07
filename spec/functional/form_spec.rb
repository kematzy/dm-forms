
describe DataMapper::Form::Base do
  
  include DataMapper::Form::Elements
  
  it "should create forms defaulting to method of post" do
    s = form :register
    s.should == %(<form method="post"></form>\n)
  end
  
  it "should create forms with custom methods" do
    s = form :register, :method => :get
    s.should == %(<form method="get"></form>\n)
  end
  
  it "should create forms with a block for inner html context" do
    s = form :login do |f|
      f.textfield :name, :title => 'Username'
      f.textfield :pass, :title => 'Password'
      f.submit :op, :title => 'Login'
    end
    s.should == <<-HTML.deindent
      <form method="post"><label for="op">Login:</label>
      <input type="submit" class="form-submit form-op" name="op" />
      </form>
    HTML
  end
  
end