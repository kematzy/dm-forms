
require 'dm-core'
require 'dm-validations'

include DataMapper::Form::ModelElements

DataMapper.setup :default, 'sqlite3::memory:'

class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String, :format => /^[\w]+$/
  property :email, String, :format => :email_address
end

DataMapper.auto_migrate!

describe DataMapper::Form::ModelElements do
  
  before :each do
    @user = User.new :name => 'invalid username', :email => 'is_valid@email.com'
  end
  
  it "should create a list of errors when a model is invalid" do
    errors_for(@user).should == <<-HTML.dedent
      <ul class="messages error">
      <li>Name has an invalid format</li>
      </ul>
    HTML
    @user.email = 'invalid email@ something.com'
    errors_for(@user).should == <<-HTML.dedent
      <ul class="messages error">
      <li>Name has an invalid format</li>
      <li>Email has an invalid format</li>
      </ul>
    HTML
  end
  
  it "should create model specific forms with errors on elements" do
    results = form_for @user do |f|
      f.textfield :name
      f.textfield :email
      f.submit :op, :value => 'Save'
    end
    results.should == <<-HTML.dedent
      <form method="post" id="form-user"><input type="textfield" class="error form-textfield form-name" name="name" />
      <input type="textfield" class="form-textfield form-email" name="email" />
      <input type="submit" class="form-submit form-op" value="Save" name="op" />
      </form>
    HTML
  end
  
  it "should use _method put for updating records" do
    @user.name = 'tj'
    @user.save
    results = form_for @user, :action => '/register' do |f|
      f.textfield :name
      f.textfield :email
      f.submit :op, :value => 'Save'
    end
    results.should == <<-HTML.dedent
      <form method="post" action="/register" id="form-user"><input type="hidden" value="put" name="_method" />
      <input type="textfield" class="form-textfield form-name" name="name" />
      <input type="textfield" class="form-textfield form-email" name="email" />
      <input type="submit" class="form-submit form-op" value="Save" name="op" />
      </form>
    HTML
  end
  
end