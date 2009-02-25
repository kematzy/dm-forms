
describe DataMapper::Form::Helpers do
  
  include DataMapper::Form::Helpers
  
  describe "#new_form_context" do
    it "should create a new context each time its called" do
      a = new_form_context
      b = new_form_context
      a.should be_a(DataMapper::Form::Base)
      b.should be_a(DataMapper::Form::Base)
      a.should_not == b
    end
  end 
  
  describe "#form_context" do
    it "should utilize the previous context or create a new one when not present" do
      a = form_context
      b = form_context
      a.should be_a(DataMapper::Form::Base)
      b.should be_a(DataMapper::Form::Base)
      a.should == b
    end
  end
  
end