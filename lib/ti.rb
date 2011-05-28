$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'pathname'
require 'fileutils'
require 'rbconfig'
require 'colored'
require 'rocco'
require 'thor'
require 'erubis'
require 'rbconfig'
require 'nokogiri'

module Ti
  ROOT_PATH         = Pathname(__FILE__).dirname.expand_path
  TITANIUM_VERSION  = '1.6.2'
  
  # TODO: Need to support those how have install Titanium in their $HOME dir.
  OSX_TITANIUM_HOME = "$HOME/Library/Application\\ Support/Titanium/mobilesdk/osx/#{::Ti::TITANIUM_VERSION}/titanium.py"
  OSX_TITANIUM      = "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{::Ti::TITANIUM_VERSION}/titanium.py"
  LINUX_TITANIUM    = "$HOME/.titanium/mobilesdk/linux/#{::Ti::TITANIUM_VERSION}/titanium.py"
  
  autoload  :VERSION,       'ti/version.rb'
  autoload  :CLI,           'ti/cli.rb'
  autoload  :Logger,        "ti/logger.rb"
  autoload  :Utils,         "ti/utils.rb"
  
  module Compiler
    autoload :CoffeeScripts,  'ti/compiler/coffee_scripts.rb'
    autoload :SASSScripts,    'ti/compiler/sass_scripts.rb'
  end
  
  module Generate
    autoload  :Project,     "ti/generate/project.rb"
    autoload  :Model,       "ti/generate/model.rb"
    autoload  :View,        "ti/generate/view.rb"
    autoload  :Controller,  "ti/generate/controller.rb"
  end
  
  def self.root
    @root ||= Pathname(__FILE__).dirname.expand_path
  end
  
end
