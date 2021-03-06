require 'spec_helper'

describe Phaad::Generator, "if" do
  it "should parse if statements" do
    compile("if a\nb\nend").should == "if($a) {\n  $b;\n}"
    compile("if a\nb\nc\nend").should == "if($a) {\n  $b;\n  $c;\n}"
  end

  it "should parse if else statements" do
    compile("if a\nb\nelse\nc\nend").should == "if($a) {\n  $b;\n} else {\n  $c;\n}"
  end

  it "should parse if elsif statements" do
    compile("if a\nb\nelsif c\nd\nend").should == 
      "if($a) {\n  $b;\n} elseif($c) {\n  $d;\n}"
  end

  it "should parse if elsif else statements" do
    compile("if a\nb\nelsif c\nd\nelse\n e\nend").should == 
      "if($a) {\n  $b;\n} elseif($c) {\n  $d;\n} else {\n  $e;\n}"
  end

  it "should parse if then end statements" do
    compile("if a then b end").should == "if($a) {\n  $b;\n}"
  end

  it "should parse if then else end statements" do
    compile("if a then b else c end").should == "if($a) {\n  $b;\n} else {\n  $c;\n}"
  end

  it "should parse if then elsif else end statements" do
    compile("if a then b elsif c then d else e end").should == 
      "if($a) {\n  $b;\n} elseif($c) {\n  $d;\n} else {\n  $e;\n}"
  end

  it "should parse one line if statements" do
    compile("b if a").should == "if($a) {\n  $b;\n}"
  end

  it "should parse unless statements" do
    compile("unless a\nb\nend").should == "if(!($a)) {\n  $b;\n}"
    compile("unless a\nb\nc\nend").should == "if(!($a)) {\n  $b;\n  $c;\n}"
    compile("unless a + b\nc\nend").should == "if(!($a + $b)) {\n  $c;\n}"
  end

  it "should parse one line if statements" do
    compile("b unless a").should == "if(!($a)) {\n  $b;\n}"
  end
end
