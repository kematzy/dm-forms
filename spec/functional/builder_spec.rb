
describe DataMapper::Form::Builder do
  
  include DataMapper::Form::Helpers
  
  it "should description" do
    results = form :action => '/login' do
      text_field :name, :label => 'Username'
      password_field :pass, :label => 'Password'
      submit 'Login'
    end
    p results
  end
  
end