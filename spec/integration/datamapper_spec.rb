
require 'dm-core'
require 'dm-validations'

DataMapper.setup :default, 'sqlite3::memory:'

class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String, :format => /^[\w]+$/
  property :email, String, :format => :email_address
end

DataMapper.auto_migrate!

describe DataMapper::Form::Helpers do
  
  include DataMapper::Form::Helpers
  
  before :each do
    @valid_user   = User.new :name => 'foo bar', :email => 'is-valid@email.com'
    @invalid_user = User.new :name => 'foobar',  :email => 'is-valid@email.com'
  end
  
  describe "#new_form_context" do
    it "should generate a name used for prefixing form element names" do
      new_form_context(@valid_user, self).name.should == 'user'
    end
  end
  
  describe "#form_for" do
    it "should create a form in context to a model" do
      markup = form_for @valid_user do
        textfield :name, :id => 'username'
        textfield :pass, :id => 'password'
      end
      puts markup
    end
  end
  
  %w( textfield submit file button hidden password radio checkbox ).each do |type|
    describe "##{type}" do
      it "should create a bound #{type}" do
        
      end
    end
  end
  
end