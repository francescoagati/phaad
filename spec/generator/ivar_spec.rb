require 'spec_helper'

describe Phaad::Generator, "instance variables" do
  it "should parse instance variable correctly" do
    
    class_wrapper=%{
    class A 
      def mt() 
        {{yield}}
      end
    end
    }
    
    compile(class_wrapper.gsub("{{yield}}","@a")).should == %{
      class A  {
        function mt() {
          $this->a;
        }
      }
    }
    
    #compile("@a = 1").should == "$this->a = 1;"
  end
end
