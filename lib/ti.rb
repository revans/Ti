$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'pathname'
require 'fileutils'
require 'colored'
require 'rocco'

# @@ti = Pathname(__FILE__).dirname.expand_path


module Ti
  ROOT_PATH       = Pathname(__FILE__).dirname.expand_path unless ::Ti::ROOT_PATH.defined?
  VERSION         = '1.6.0'
  
  # TODO: Need to support those how have install Titanium in their $HOME dir.
  
  OSX_TITANIUM    = "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{::Ti::VERSION}/titanium.py"
  LINUX_TITANIUM  = "$HOME/.titanium/mobilesdk/linux/#{::Ti::VERSION}/titanium.py"
  
  autoload  :Logger,  "ti/logger.rb"
  autoload  :Utils,   "ti/utils.rb"
  
  module Generate
    autoload  :Project, "ti/generate/project.rb"
  end
  
  # TODO: Pull this into it's own file. Generate should be a module and a new project should be the class. 
  #       e.g. Ti::Generate::Project.new(name, id, platform)
  #       e.g. Ti::Generate::Model.new(name, options)
end
