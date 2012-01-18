$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'pathname'
require 'fileutils'
require 'rbconfig'
require 'colored'
require 'rocco'
require 'thor'
require 'erubis'
require 'nokogiri'

module Ti
  ROOT_PATH         = Pathname(__FILE__).dirname.expand_path

  autoload  :VERSION,       'ti/version.rb'
  autoload  :CLI,           'ti/cli.rb'
  autoload  :Logger,        "ti/logger.rb"
  autoload  :Utils,         "ti/utils.rb"

  module Compiler
    autoload :CoffeeScripts,  'ti/compiler/coffee_scripts.rb'
    autoload :SASSScripts,    'ti/compiler/sass_scripts.rb'
  end

  module Builder
    autoload :Titanium,     "ti/builder/titanium.rb"
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
