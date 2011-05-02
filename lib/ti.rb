$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'pathname'
require 'fileutils'
require 'colored'
require 'rocco'
require 'ostruct'

module Ti
  VERSION           = File.read(File.join(File.dirname(__FILE__), '../VERSION')).chomp
  ROOT_PATH         = Pathname(__FILE__).dirname.expand_path
  TITANIUM_VERSION  = '1.6.0'
  
  # TODO: Need to support those how have install Titanium in their $HOME dir.
    
  OSX_TITANIUM    = "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{::Ti::TITANIUM_VERSION}/titanium.py"
  LINUX_TITANIUM  = "$HOME/.titanium/mobilesdk/linux/#{::Ti::TITANIUM_VERSION}/titanium.py"
  
  autoload  :Options,       'ti/options.rb'
  autoload  :ParseOptions,  'ti/parse_options.rb'
  autoload  :Logger,        "ti/logger.rb"
  autoload  :Utils,         "ti/utils.rb"
  
  module Generate
    autoload  :Project,     "ti/generate/project.rb"
    autoload  :Model,       "ti/generate/model.rb"
    autoload  :View,       "ti/generate/view.rb"
  end
  
end
