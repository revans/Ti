$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'pathname'
require 'fileutils'

@@ti = Pathname(__FILE__).dirname.expand_path


module Ti
  VERSION         = '1.6.0'
  # TODO: Need to support those how have install Titanium in their $HOME dir.
  OSX_TITANIUM    = "/Library/Application\\ Support/Titanium/mobilesdk/osx/#{VERSION}/titanium.py"
  LINUX_TITANIUM  = "$HOME/.titanium/mobilesdk/linux/#{VERSION}/titanium.py"

  class Generate
    class << self
      attr_accessor :project_name, :devise_platform, :app_id


      # Ti::Generate.new_project('demo', 'org.codewranglers.demo', 'ipad')
      def new_project(name, id, platform='iphone')
        @project_name    = name
        @devise_platform = platform
        @app_id          = id
        if `#{generate_titanium_project}`
          remove_files
          generate_files
        end
      end


      def create_new_file(name, contents)
        File.open(location.join(name), 'w') { |f| f.write(contents) }
      end


      def remove_files
        FileUtils.rm_rf(location.join('Resources'))
        FileUtils.rm(location.join('README'))
      end


      def generate_files
        ['Resources', 'src', 'docs', 'specs'].each do |f| 
          FileUtils.mkdir(location.join(f))
        end
        FileUtils.touch(location.join('Readme.mkd'))
        create_new_file("src/app.coffee", '')
        create_new_file(".gitignore", File.read(@@ti.join('ti/gitignore')))

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
