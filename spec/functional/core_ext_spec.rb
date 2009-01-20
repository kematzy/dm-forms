

describe "core ext" do
  
  #--
  # Humanize
  #++
  
  describe "String#humanize" do

    it "should humanize strings" do
      'im_a_Lame_String.Yeah.with.7.words'.humanize.should == 'im a Lame String Yeah with 7 words'
    end

    it "should humanize symbols" do
      :some_Cool_symbol.humanize.should == 'some Cool symbol'
      :login.humanize.should == 'login'
    end

    it "should not mess with already human readable strings" do
      'i am already VERY readable'.humanize.should == 'i am already VERY readable'
    end

  end
  
  #--
  # Indent
  #++
  
  describe "String#indent" do
    
    it "should indent 2 spaces by default" do
      'meow'.indent.should == '  meow'
    end
    
    it "should indent variable tab lengths" do
      'meow'.indent(2).should == '    meow'
    end
    
    it "should indent multi-line strings" do
      string = <<-EOF.dedent
      foo
      bar
      EOF
      string.indent.should == <<-EOF.dedent
        foo
        bar
      EOF
      string.indent(2).should == <<-EOF.dedent
          foo
          bar
      EOF
    end
    
  end
end