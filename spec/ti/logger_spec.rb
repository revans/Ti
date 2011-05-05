require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "The Logger" do
  before(:each) do
    @stdout_orig  = $stdout 
    $stdout       = StringIO.new
    
    @stderr_orig  = $stderr
    $stderr       = StringIO.new
  end
  
  context "Reporting an error" do
    it "should output a formatted message with a red color" do
      Ti::Logger.error("This is failing.")
      $stderr.string.should == "\e[1m\e[31mThis is failing.\e[0m\e[0m\n"
    end
  end
  
  context "Reporting back a success" do
    it "should output a formatted message with a green color" do
      Ti::Logger.report("This is a success.")
      $stdout.string.should == "\e[1m\e[32mThis is a success.\e[0m\e[0m\n"
    end
  end
end