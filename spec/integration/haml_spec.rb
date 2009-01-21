
require 'rubygems'
require 'haml'

include DataMapper::Form::Elements

describe "Haml + dm-forms" do
      
  it "should create pretty forms :D" do
    engine = Haml::Engine.new <<-HAML.dedent
      .comments
        %h1 Comments
        = textfield :name
        = textfield :email
        = textarea :comments
        = submit :op, :value => 'Submit'
    HAML
    engine.render.should have_tag('div[@class="comments"]') do |div|
      div.should have_tag('h1', 'Comments')
      div.should have_tag('input', :count => 3)
      div.should have_tag('textarea')
    end
  end
  
end