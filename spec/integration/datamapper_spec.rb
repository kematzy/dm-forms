
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
    errors_for(@user).should have_tag('ul[@class="messages error"]') do |ul|
      ul.should have_tag('li', 'Name has an invalid format')
    end
    @user.email = 'invalid email@ something.com'
    errors_for(@user).should have_tag('ul[@class="messages error"]') do |ul|
      ul.should have_tag('li', 'Name has an invalid format')
      ul.should have_tag('li', 'Email has an invalid format')
    end
  end
  
  it "should create model specific forms with errors on elements" do
    results = form_for @user do |f|
      f.textfield :name
      f.textfield :email
      f.submit :op, :value => 'Save'
    end
    results.should have_tag('form[@method="post"]') do |form|
      form.should have_tag('input', :count => 3)
    end
  end
  
  it "should use _method put for updating records" do
    @user.name = 'tj'
    @user.save
    results = form_for @user, :action => '/register' do |f|
      f.textfield :name
      f.textfield :email
      f.submit :op, :value => 'Save'
    end
    results.should have_tag('form[@action="/register"]') do |form|
      form.should have_tag('input', :count => 4)
      form.should have_tag('input[@type="hidden"]') do |hidden|
        hidden[:value].should == 'put'
        hidden[:name].should == '_method'
      end
    end
  end
  
end