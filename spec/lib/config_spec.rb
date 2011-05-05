require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Ti Config" do
  context "Reading the Ti app config file (tiapp.xml)" do
    before (:all) do
      @config = Ti::Config.new
      @config.parse(fixture_file(:config, 'tiapp.xml'))
    end
    it "should be able to get the id" do
      @config.id.should eql("com.mycompany.demo")
    end
    it "should be able to get the name" do
      @config.name.should eql("Demo")
    end
    it "should be able to get the version"  do
      @config.version.should eql("1.0")
    end
    it "should be able to get the publisher"  do
      @config.publisher.should eql("Rupak Ganguly")
    end
    it "should be able to get the url"  do
      @config.url.should eql("www.mycompany.com")
    end
    it "should be able to get the description"  do
      @config.description.should eql("The Demo project.")
    end
    it "should be able to get the copyright"  do
      @config.copyright.should eql("2011 by Rupak Ganguly")
    end
  end
  context "Write tiapp.xml config file" do

  end
end