require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "The utilities" do
  
  before(:each) do
    class Klass
      class << self
        include ::Ti::Utils
      end
    end
  end
  
  it "should return the base location" do
    Klass.base_location.should == Pathname.new(Dir.pwd)
  end
  
  it "should have the base location alias, location return the base location" do
    Klass.location.should == Pathname.new(Dir.pwd)
  end
  
  context "Creating new files and deleting them" do
    it "should create a new file" do
      Klass.create_new_file("DEMO")
      File.exists?(Pathname.new(Dir.pwd).join("DEMO")).should be_true
    end
    
    it "should delete the new file" do
      Klass.remove_files("DEMO")
      File.exists?(Pathname.new(Dir.pwd).join("DEMO")).should be_false
    end
    
    after(:all) do
      remove_directories("DEMO")
    end
  end
  
  context "Touching files into existence like no one has touched a file before" do
    it "should come alive!!" do
      Klass.touch("File", "into", "existence")
      File.exists?(Pathname.new(Dir.pwd).join("File")).should       be_true
      File.exists?(Pathname.new(Dir.pwd).join("into")).should       be_true
      File.exists?(Pathname.new(Dir.pwd).join("existence")).should  be_true
    end
    
    after(:all) do
      remove_directories("File", "into", "existence")
    end
  end
  
  context "Creating Model Files and their spec files" do
    it "should create the model directory" do
      Klass.create_model_file("user")
      File.directory?(Pathname.new(Dir.pwd).join("app/models")).should be_true
      File.exists?(Pathname.new(Dir.pwd).join("app/models/user.coffee")).should be_true
      File.exists?(Pathname.new(Dir.pwd).join("spec/models/user_spec.coffee")).should be_true
    end
    
    after(:all) do
      remove_directories('app', 'spec/views', 'spec/models')
    end
  end
  
  context "Creating View Files and their spec files" do
    it "should create the model directory" do
      Klass.create_view_file("user")
      File.directory?(Pathname.new(Dir.pwd).join("app/views")).should be_true
      File.exists?(Pathname.new(Dir.pwd).join("app/views/user.coffee")).should be_true
      File.exists?(Pathname.new(Dir.pwd).join("spec/views/user_spec.coffee")).should be_true
    end
    
    after(:all) do
      remove_directories('app', 'spec/views', 'spec/models')
    end
  end
  
  context "Creating and deleting directories" do
    it "should create some directories" do
      Klass.create_directories("Dude", "looks", "like", "a", "lady")
      File.exists?(Pathname.new(Dir.pwd).join("Dude")).should   be_true
      File.exists?(Pathname.new(Dir.pwd).join("looks")).should  be_true
      File.exists?(Pathname.new(Dir.pwd).join("like")).should   be_true
      File.exists?(Pathname.new(Dir.pwd).join("a")).should      be_true
      File.exists?(Pathname.new(Dir.pwd).join("lady")).should   be_true
    end
    
    it "should delete the created directories" do
      Klass.remove_directories("Dude", "looks", "like", "a", "lady")
      File.exists?(Pathname.new(Dir.pwd).join("Dude")).should   be_false
      File.exists?(Pathname.new(Dir.pwd).join("looks")).should  be_false
      File.exists?(Pathname.new(Dir.pwd).join("like")).should   be_false
      File.exists?(Pathname.new(Dir.pwd).join("a")).should      be_false
      File.exists?(Pathname.new(Dir.pwd).join("lady")).should   be_false
    end
    
    after(:all) do
      remove_directories("Dude", "looks", "like", "a", "lady")
    end
  end
  
  context "Test the Utils logging" do
    before(:each) do
      @stdout_orig  = $stdout 
      $stdout       = StringIO.new

      @stderr_orig  = $stderr
      $stderr       = StringIO.new
    end
    
    it "should log the error" do
      Klass.error("Failed")
      $stderr.string.should == "\e[1m\e[31mFailed\e[0m\e[0m\n"
    end
    
    it "should log the success" do
      Klass.log("Success")
      $stdout.string.should == "\e[1m\e[32mSuccess\e[0m\e[0m\n"
    end
  end
    
end