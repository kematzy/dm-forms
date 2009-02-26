
require 'dm-core'
require 'dm-validations'

DataMapper.setup :default, 'sqlite3::memory:'

class User
  include DataMapper::Resource
  property :id,        Serial
  property :name,      String, :format => /^[\w]+$/
  property :email,     String, :format => :email_address
  property :signature, Text,   :nullable => true, :lazy => false
end

class User::Role
  include DataMapper::Resource
  property :id,   Serial
  property :name, String
end

DataMapper.auto_migrate!

describe DataMapper::Form::Helpers do
  
  include DataMapper::Form::Helpers
  
  before :each do
    @valid_user = User.new :name => 'foo bar', :email => 'is-valid@email.com', :signature => 'i like cookies'
    @invalid_user = User.new :name => 'foobar',  :email => 'is-valid@email.com', :signature => 'i like cookies'
    @admin_role = User::Role.new :name => 'admin'
  end
  
  describe "#new_form_context" do
    it "should generate a name used for prefixing form element names" do
      new_form_context(@admin_role, self).name.should == 'role'
    end
  end
  
  describe "#form_for" do
    it "should create a form in context to a model" do
      markup = form_for @valid_user do
        textfield :name, :id => 'username'
        password :pass, :id => 'password'
      end
      markup.should have_tag('form') do |form|
        form.should have_tag('input[@name=user[name]]') { |name| name.attributes['value'].should == 'foo bar' }
        form.should have_tag('input[@name=user[pass]]')
      end
    end
  end
  
  describe "#fields_for" do
    it "should create a temporary context within a form" do
      markup = form_for @valid_user do
        textfield :name, :id => 'username'
        fields_for @admin_role do
          textfield :name, :id => 'role-name'
        end
        password :pass, :id => 'password'
      end
      markup.should have_tag('form') do |form|
        form.should have_tag('input[@name=user[name]]') { |name| name.attributes['value'].should == 'foo bar' }
        form.should have_tag('input[@name=user[pass]]')
        form.should have_tag('input[@name=role[name]]')
      end
    end
  end
  
  describe "#fieldset_for" do
    it "should create a fieldset in context to a model" do
      markup = form_for @valid_user do
        textfield :name, :id => 'username'
        fieldset_for @admin_role, :legend => 'Role' do
          textfield :name, :id => 'role-name'
        end
        password :pass, :id => 'password'
      end
      markup.should have_tag('form') do |form|
        form.should have_tag('input[@name=user[name]]') { |name| name.attributes['value'].should == 'foo bar' }
        form.should have_tag('input[@name=user[pass]]') 
        form.should have_tag('fieldset') do |fieldset|
          fieldset.should have_tag('legend', 'Role')
          fieldset.should have_tag('input[@name=role[name]]')
        end
      end
    end
  end
  
  describe "#textarea" do
    it "should default its contents using the models method" do
      markup = fields_for @valid_user do
        textarea :signature
      end
      markup.should have_tag('textarea[@name=user[signature]]', 'i like cookies')
    end
  end
  
end