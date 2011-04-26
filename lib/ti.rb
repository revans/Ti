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
  TI_TEMP         = "/tmp/ti_temp"

  class Generate
    class << self
      attr_accessor :project_name, :devise_platform, :app_id


      # Ti::Generate.new_project('demo', 'org.codewranglers.demo', 'ipad')
      def new_project(name, id, platform='iphone')
        @project_name    = name
        @devise_platform = platform
        @app_id          = id
        if `#{generate_titanium_project}`
          remove_old_files
          generate_files
          log "Your Titanium project is ready for you to get rockin!"
        else
          error "There was an error generating your Titanium project."
        end
      end


      def create_new_file(name, contents)
        log "Creating #{name}"
        File.open(location.join(name), 'w') { |f| f.write(contents) }
      end

      def touch(*filenames)
        filenames.each do |filename|
          log "Creating #{filename} file."
          FileUtils.touch(location.join(filename))
        end
      end

      def create_directories(*dirs)
        dirs.each do |dir|
          log "Creating the #{dir} directory."
          FileUtils.mkdir_p(location.join(dir))
        end
      end

      
      def remove_directories(*names)
        names.each do |name|
          log "Removing #{name} directory."
          FileUtils.rm_rf(location.join(name))
        end
      end

      def remove_files(*files)
        files.each do |file|
          log "Removing #{file} file."
          FileUtils.rm(location.join(file))
        end
      end
  

      def remove_old_files
        remove_files('README')
        remove_directories('Resources')
      end

      def create_temp_folder(destroy=false)
        if destroy
          FileUtils.rm_rf TI_TEMP
        else
          FileUtils.mkdir TI_TEMP
        end
      end

      def copy_defaults
        create_temp_folder
        FileUtils.cp("Resources/KS_nav_ui.png", "/tmp/ti_temp/")
        FileUtils.cp("Resources/KS_nav_views.png", "/tmp/ti_temp/")
      end


      def generate_files
        create_directories('Resources', 'src', 'docs', 'specs', 'Resources/images', 'Resources/stylesheets', 'Resources/vendor') 
        touch('Readme.mkd')
        # create_new_file("src/app.coffee", '')
        create_new_file("src/app.coffee", File.read(@@ti.join('ti/templates/app.coffee')))
        create_new_file(".gitignore", File.read(@@ti.join('ti/gitignore')))
        create_new_file("config.rb",  File.read(@@ti.join('ti/config')))
        create_new_file("Rakefile",   File.read(@@ti.join('ti/rakefile')))

        # load default images
        FileUtils.cp("/tmp/ti_temp/*.png", "Resources/images/")

        # Destroy temp folder
        create_temp_folder true
      end


      def location
        @location ||= Pathname.new(Dir.pwd).join(@project_name)
      end


      def generate_titanium_project
        "#{OSX_TITANIUM} create --name=#{@project_name} --platform=#{@devise_platform} --id=#{@app_id}"
      end


      def log(msg)
        $stdout.puts(msg.green.bold)
      end

      def error(msg)
        $stderr.puts(msg.red.bold)
      end

    end
  end
end
