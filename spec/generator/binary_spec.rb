require 'spec_helper'

describe Phaad::Generator, "binary" do
  it "should parse +, -, *, /, %" do
    compile("1 + 2").should == "1 + 2;"
    compile("1 - 2").should == "1 - 2;"
    compile("1 * 2").should == "1 * 2;"
    compile("1 / 2").should == "1 / 2;"
    compile("1 % 2").should == "1 % 2;"
  end

  it "should parse | & ^" do
    compile("1 | 2").should == "1 | 2;"
    compile("1 & 2").should == "1 & 2;"
    compile("1 ^ 2").should == "1 ^ 2;"
  end

  it "should parse ** to pow" do
    compile("1 ** 2").should == "pow(1, 2);"
  end

  it "should parse && ||" do
    compile("true && false").should == "TRUE && FALSE;"
    compile("true || false").should == "TRUE || FALSE;"
  end

  it "should parse 'and' and 'or'" do
    compile("true and false").should == "TRUE && FALSE;"
    compile("true or false").should == "TRUE || FALSE;"
  end

  it "should parse chain of binary statements" do
    compile("1 + 2 - 3 + 4").should == "1 + 2 - 3 + 4;"
    compile("1 + 2 ** 3 ** 4").should == "1 + pow(2, pow(3, 4));"
  end

  it "should parse == != > < >= <= ===" do
    compile("1 == 2").should == "1 == 2;"
    compile("1 != 2").should == "1 != 2;"
    compile("1 > 2").should == "1 > 2;"
    compile("1 < 2").should == "1 < 2;"
    compile("1 >= 2").should == "1 >= 2;"
    compile("1 <= 2").should == "1 <= 2;"
    compile("1 === 2").should == "1 === 2;"
  end

  it "should parse =~ and !~ to preg_match statements" do
    compile("a =~ b").should == "preg_match($b, $a);"
    compile("a !~ b").should == "!preg_match($b, $a);"
  end
end
