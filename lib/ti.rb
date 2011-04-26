$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'pathname'
require 'fileutils'
require 'colored'
require 'rocco'

@@ti = Pathname(__FILE__).dirname.expand_path


module Ti
  VERSION         = '1.6.0'
  
  # TODO: Need to support those how have install Titanium in their $HOME dir.
  
  OSX_TITANIUM    = "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{VERSION}/titanium.py"
  LINUX_TITANIUM  = "$HOME/.titanium/mobilesdk/linux/#{VERSION}/titanium.py"
  
  autoload  :Logger,  "ti/logger.rb"
  autoload  :Utils,   "ti/utils.rb"

  class Generate
    class << self
      attr_accessor :project_name, :devise_platform, :app_id
      include Utils

      # Ti::Generate.new_project('demo', 'org.codewranglers.demo', 'ipad')
      def new_project(name, id, platform='iphone')
        @project_name    = name
        @devise_platform = platform
        @app_id          = id
        if `#{generate_titanium_project}`
          copy_defaults
          remove_old_files
          generate_files
          log "Your Titanium project is ready for you to get rockin!"
        else
          error "There was an error generating your Titanium project."
        end
      end


      

      def copy_defaults
        create_temp_folder
        FileUtils.cp(location.join("Resources/KS_nav_ui.png"),    "/tmp/ti_temp/")
        FileUtils.cp(location.join("Resources/KS_nav_views.png"), "/tmp/ti_temp/")
      end


      def generate_files
        create_directories('Resources', 'app', 'docs', 'specs', 'Resources/images', 'Resources/vendor', 'app/models', 'app/views', 'app/stylesheets', 'config') 
        touch('Readme.mkd')

        
        create_new_file("app/app.coffee",     File.read(@@ti.join('ti/templates/app/app.coffee')))
        create_new_file(".gitignore",         File.read(@@ti.join('ti/templates/gitignore')))
        create_new_file("config/config.rb",   File.read(@@ti.join('ti/templates/config')))
        create_new_file("Rakefile",           File.read(@@ti.join('ti/templates/rakefile')))
        create_new_file("Readme.mkd",         File.read(@@ti.join('ti/templates/readme')))

        # load default images
        FileUtils.cp("/tmp/ti_temp/KS_nav_ui.png",    location.join("Resources/images/"))
        FileUtils.cp("/tmp/ti_temp/KS_nav_views.png", location.join("Resources/images/"))

        # Destroy temp folder
        create_temp_folder true
      end


      def location
        @location ||= Pathname.new(Dir.pwd).join(@project_name)
      end


      def generate_titanium_project
        "#{OSX_TITANIUM} create --name=#{@project_name} --platform=#{@devise_platform} --id=#{@app_id}"
      end

    end
  end
end
