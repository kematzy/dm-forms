
require 'rubygems'
require 'haml'

include DataMapper::Form::Elements

describe "Haml + dm-forms" do
  
  it "should create pretty forms :D" do
    engine = Haml::Engine.new <<-HAML.deindent
    .comments
      %h1 Comments
      = textfield :name
      = textfield :email
      = textarea :comments
      = submit :op, :value => 'Submit'
    HAML
    engine.render.should == <<-HTML.deindent
      <div class='comments'></div>
      <h1>Comments</h1>
      <input type=\"textfield\" class=\"form-textfield form-name\" name=\"name\" />
      <input type=\"textfield\" class=\"form-textfield form-email\" name=\"email\" />
      <textarea class=\"form-textarea form-comments\" name=\"comments\"></textarea>
      <input type=\"submit\" class=\"form-submit form-op\" value=\"Submit\" name=\"op\" />
    HTML
  end
  
end