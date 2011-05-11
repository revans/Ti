require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Creating of a view file" do
  before(:each) do
    ::Ti::Generate::Project.create('dailyfocus', 'org.codewranglers.demo', 'ipad')
  end
  
  context "Creating a view file and its spec" do
    before(:all) do
      # system("cd dailyfocus && ti g view user")
    end
    
    it "should have created the view coffee-script within the app/views directory" do
      # File.exists?("app/dailyfocus/views/user.coffee").should be_true
    end
    
    it "should have created the view coffee-script within the spec/views directory" do
      # File.exists?("spec/views/user_spec.coffee").should be_true
    end
  end
  
  after(:all) do
    remove_directories('dailyfocus', 'app', 'spec/views')
  end
end