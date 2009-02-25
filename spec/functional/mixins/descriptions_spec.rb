
describe DataMapper::Form::Descriptions do
  
  include DataMapper::Form::Helpers
  include DataMapper::Form::Descriptions
  
  it "should create elements like normal when descriptions are not utilized" do
    markup = textfield :name => 'email'
    markup.should have_tag('input[@type=textfield]')
    markup.should_not have_tag('span[@class=description]')
  end
  
  it "should create elements with descriptions" do
    markup = textfield :name => 'email', :description => 'Please enter a valid email.'
    markup.should have_tag('input[@type=textfield]')
    markup.should have_tag('span[@class=description]')
  end
  
end