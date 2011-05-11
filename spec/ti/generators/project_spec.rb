require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Creating of a new Ti Project" do
  before(:all) do
    ::Ti::Generate::Project.create('dailyfocus', 'org.codewranglers.demo', 'ipad')
  end
  
  context "Directories should be created" do
    
    it "should have created the project" do
      File.directory?("dailyfocus").should be_true
    end
    
    it "should have an app directory" do
      File.directory?("dailyfocus/app").should be_true
    end
    
    it "should have a config directory" do
      File.directory?("dailyfocus/config").should be_true
    end
    
    it "should have a docs directory" do
      File.directory?("dailyfocus/docs").should be_true
    end
    
    it "should have a Resources directory" do
      File.directory?("dailyfocus/Resources").should be_true
    end
    
    it "should have a specs directory" do
      File.directory?("dailyfocus/specs").should be_true
    end
    
    it "should have a tmp directory" do
      File.directory?("dailyfocus/tmp").should be_true
    end
  end
  
  context "Top tier files should be created" do
    it "should have created the Guardfile" do
      File.exists?("dailyfocus/Guardfile").should be_true
    end
    
    it "should have created the LICENSE" do
      File.exists?("dailyfocus/LICENSE").should be_true
    end
    
    it "should have created the Rakefile" do
      File.exists?("dailyfocus/Rakefile").should be_true
    end
    
    it "should have created the Readme.mkd" do
      File.exists?("dailyfocus/Readme.mkd").should be_true
    end
    
    it "should have created the tiapp.xml" do
      File.exists?("dailyfocus/tiapp.xml").should be_true
    end
  end
  
  context "Inside the app directory" do
    it "should have created the app.coffee file" do
      File.exists?("dailyfocus/app/app.coffee").should be_true
    end
    
    it "should have created the models directory" do
      File.directory?("dailyfocus/app/dailyfocus/models").should be_true
    end
    
    it "should have created the stylesheets directory" do
      File.directory?("dailyfocus/app/dailyfocus/stylesheets").should be_true
    end
    
    it "should have created the views directory" do
      File.directory?("dailyfocus/app/dailyfocus/views").should be_true
    end
  end
  
  context "Inside the config directory" do
    it "should have created the config.rb file" do
      File.exists?("dailyfocus/config/config.rb").should be_true
    end
  end
  
  context "Inside the Resources directory" do
    it "should have created the images directory" do
      File.directory?("dailyfocus/Resources/images").should be_true
    end
    
    it "should have created the vendor directory" do
      File.directory?("dailyfocus/Resources/vendor").should be_true
    end
    
    it "should have created the KS_nav_ui.png within the images directory" do
      File.exists?("dailyfocus/Resources/images/KS_nav_ui.png").should be_true
    end
    
    it "should have created the KS_nav_views.png within the images directory" do
      File.exists?("dailyfocus/Resources/images/KS_nav_views.png").should be_true
    end
  end
  
  context "Inside the specs directory" do
    it "should have created the app_spec.coffee file" do
      File.exists?("dailyfocus/specs/app_spec.coffee").should be_true
    end
    
    it "should have created the models directory" do
      File.directory?("dailyfocus/specs/models").should be_true
    end
    
    it "should have created the views directory" do
      File.directory?("dailyfocus/specs/views").should be_true
    end
    
  end
  
  after(:all) do
    remove_directories('dailyfocus')
  end
end