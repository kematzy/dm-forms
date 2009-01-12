
require 'dm-core'
require 'dm-validations'

include DataMapper::Form::ModelElements

DataMapper.setup :default, 'sqlite3::memory:'

class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String, :format => :email_address
  property :email, String, :format => /^[\w]+$/
end

DataMapper.auto_migrate!

describe DataMapper::Form::ModelElements do
  
  before :each do
    @user = User.new :name => 'invalid username', :email => 'invalid email @-lame.com'
  end
  
  it "should test hpricot" do
    errors_for(@user).should == <<-HTML.deindent
      <ul class="messages error">
      <li>Name has an invalid format</li>
      <li>Email has an invalid format</li>
      </ul>
    HTML
  end
  
  it "should create model specific forms" do
    results = form_for @user do |f|
      f.textfield :name
      f.textfield :email
      f.submit :op, :value => 'Save'
    end
    results.should == <<-HTML.deindent
      <ul class="messages error">
      <li>Name has an invalid format</li>
      <li>Email has an invalid format</li>
      </ul>
      <form id="form-user">
      <input type="textfield" name="name" />
      <input type="textfield" name="email" />
      <input type="submit" name="op" />
      </form>
    HTML
  end
  
end