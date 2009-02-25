
describe DataMapper::Form::Labels do
  
  include DataMapper::Form::Helpers
  DataMapper::Form::Base.send :include, DataMapper::Form::Labels
  
  it "should create elements like normal when labels are not utilized" do
    markup = textfield :name => 'email'
    markup.should have_tag('input[@type=textfield]')
    markup.should_not have_tag('label')
  end
  
  it "should create elements with labels" do
    markup = textfield :name => 'email', :label => 'Email'
    markup.should have_tag('input[@type=textfield]')
    markup.should have_tag('label[@for=email]', 'Email')
  end
  
end