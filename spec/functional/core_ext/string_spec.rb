
describe "String" do
  
  describe "#merge_word" do
    it "should add a word if it is not present" do
      'product'.merge_word('sold').should == 'product sold'
    end
    
    it "should not add the word a second time" do
      'sold product'.merge_word('sold').should == 'sold product'
    end
    
    it "should be aliased as #add_class" do
      'item large'.add_class('even').should == 'item large even'
    end
  end
  
end