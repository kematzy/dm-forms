
describe DataMapper::Form::Builder::Base do
  
  include DataMapper::Form::Helpers
  
  it "should description" do
    results = form :action => '/login' do 
      text_area 'Comments', :name => 'comments'
      submit 'Submit', :name => 'op'
    end
    puts results
  end
  
end