$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'pathname'
require 'rbconfig'
require 'fileutils'

require 'nokogiri'
require 'erubis'
require 'thor'

require 'core/string'

module Ti
  VERSION = '0.2.0'
  
  def self.version
    VERSION
  end
  
  module Source
    def self.titanium_version
      @titanium_version ||= '1.7.2'
    end
    
    def self.titanium_version=(version)
      @titanium_version = version
    end

    def self.root
      @root ||= Pathname(__FILE__).dirname.expand_path
    end
    
    def self.project_path
      @project_path ||= Pathname.new(Dir.pwd)
    end
    
    def self.compiler_path
      @compiler_path ||= case RbConfig::CONFIG['host_os']
      when /linux/i   then "$HOME/.titanium/mobilesdk/linux/#{titanium_version}/titanium.py"
      when /darwin/i  then "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{titanium_version}/titanium.py"
      else
        nil
      end
    end
    

    def self.config_options
      return @config_options if @config_options
      config    = ::File.open(project_path.join('tiapp.xml'))
      contents  = Nokogiri::XML(config)
      config.close
      @config_options ||= {
        :id               => contents.xpath('ti:app/id').text,
        :name             => contents.xpath('ti:app/name').text,
        :underscore_name  => contents.xpath('ti:app/name').text.downcase.underscore,
        :version          => contents.xpath('ti:app/version').text,
        :publisher        => contents.xpath('ti:app/publisher').text,
        :url              => contents.xpath('ti:app/url').text,
        :description      => contents.xpath('ti:app/description').text,
        :copyright        => contents.xpath('ti:app/copyright').text
      } if contents
    end
    
  end
  
  autoload :Compile,    'compile'
  autoload :CLI,        'cli'
  
  module Generator
    autoload :Base,     'generator/base'
    autoload :Project,  'generator/project'
    autoload :Model,    'generator/model'
    autoload :View,     'generator/view'
  end
  
end