
describe DataMapper::Form::Wrapper do
  
  include DataMapper::Form::Helpers
  DataMapper::Form::Base.send :include, DataMapper::Form::Wrapper
  
  it "should create wrappers around elements for styling" do
    markup = textarea :name => 'comments'
    markup.should have_tag('div[@class=form-textarea form-comments]') do |div|
      div.should have_tag('textarea')
    end
  end
    
  it "should create wrappers around elements for styling, prioritizing :type for the class" do
    markup = textfield :name => 'email'
    markup.should have_tag('div[@class=form-textfield form-email]') do |div|
      div.should have_tag('input[@type=textfield]')
    end
  end
  
end