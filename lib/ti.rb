$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'pathname'
require 'rbconfig'
require 'fileutils'

require 'nokogiri'
require 'erubis'
require 'thor'

require 'core/string'

module Ti
  
  def self.version
    '0.2.0'
  end
  
  module Source
    
    # Will always use the latest version of titanium you have to build the project
    def self.titanium_version
      @titanium_version = File.basename(Dir["#{titanium_base_path}/*"].sort.last)
    end


    # The path to Ti
    def self.root
      @root ||= Pathname(__FILE__).dirname.expand_path
    end
    
    
    # Path to the project
    def self.project_path
      @project_path ||= Pathname.new(Dir.pwd).expand_path
    end
    
    
    # Allows the user to change the titanium version within the tiapp.xml
    def self.compiler_path
      @compiler_path ||= titanium_base_path.join("#{config_options[:version]}/titanium.py")
    end
    
    
    # Base path to where titanium mobile lives
    def self.titanium_base_path
      @titanium_base_path ||= case RbConfig::CONFIG['host_os']
      when /linux/i   then Pathname.new("$HOME/.titanium/mobilesdk/linux/")
      when /darwin/i  then Pathname.new("/Library/Application\\ Support/Titanium/mobilesdk/osx/")
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