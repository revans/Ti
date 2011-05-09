require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Creating of a model" do  
  before(:all) do
    ::Ti::Generate::Project.create('dailyfocus', 'org.codewranglers.demo', 'ipad')
  end
  
  context "Creating a model file and its spec" do
    before(:all) do
      ::Ti::Generate::Model.create("user")
    end
    
    it "should have created the model coffee-script within the app/models directory" do
      File.exists?("app/models/user.coffee").should be_true
    end
    
    it "should have created the model coffee-script within the spec/models directory" do
      File.exists?("spec/models/user_spec.coffee").should be_true
    end
  end
  
  after(:all) do
    remove_directories('dailyfocus', 'app', 'spec/models')
  end
end