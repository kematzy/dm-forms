
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

describe DataMapper::Form::Base do
  
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
  
end