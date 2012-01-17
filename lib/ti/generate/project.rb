require 'session'
module Ti
  module Generate
    class Project
      class << self
        attr_accessor :project_name, :device_platform, :app_id
        include ::Ti::Utils

        # Ti::Generate::Project.create('demo', 'org.codewranglers.demo', 'ipad')
        def create(name, id, platform='iphone')
          @project_name    = name
          @device_platform = platform
          @app_id          = id
          
          if generate_titanium_project
            create_directories('tmp')
            copy_defaults
            remove_old_files
            generate_files
            log "Your Titanium project is ready for you to get coding!"
          else
            error "There was an error generating your Titanium project."
          end
        end


        def copy_defaults
          FileUtils.cp(location.join("Resources/KS_nav_ui.png"),    "/tmp/")
          FileUtils.cp(location.join("Resources/KS_nav_views.png"), "/tmp/")
        end


        def generate_files
          create_project_directory
          full_app_hash = {:app_name => @project_name, :app_name_underscore => underscore(@project_name), :platform => @device_platform}
          create_with_template('app/app.coffee', 'app/app.coffee', full_app_hash)
          create_with_template("app/#{underscore(@project_name)}/app.coffee", 'app/app_project.coffee', full_app_hash)
          create_with_template("app/#{underscore(@project_name)}/api.coffee", 'app/api.coffee', full_app_hash)

          create_with_template('.gitignore', 'defaults/gitignore', full_app_hash)

          create_new_file("spec/app_spec.coffee",   templates('specs/app_spec.coffee'))
          create_new_file("app/#{underscore(@project_name)}/stylesheets/app.sass",   templates('app/stylesheets/app.sass'))

          create_with_template('config/config.rb', 'defaults/config', full_app_hash)
          create_with_template("app/#{underscore(@project_name)}/helpers/application.coffee", 'app/helpers/application.coffee', full_app_hash)

          default_templates = ['Rakefile', 'Readme.mkd', 'Guardfile', 'Coffeefile']
          default_templates.each do |tempfile|
            create_with_template(tempfile, "defaults/#{tempfile}", full_app_hash)
          end

          # load default images
          FileUtils.cp("/tmp/KS_nav_ui.png",    location.join("Resources/images/"))
          FileUtils.cp("/tmp/KS_nav_views.png", location.join("Resources/images/"))
        end


        def create_project_directory
          create_directories('Resources', 'Resources/images', 'Resources/vendor', 
                             'config', 
                             'docs', 
                             "app/#{underscore(@project_name)}/models", 
          "app/#{underscore(@project_name)}/helpers",
          "app/#{underscore(@project_name)}/views", 
          "app/#{underscore(@project_name)}/stylesheets", 
          "app/#{underscore(@project_name)}/stylesheets/partials",
          'spec/models', 'spec/views', 'spec/helpers') 
        end

        def remove_old_files
          remove_files('README')          
          remove_directories('Resources')
        end

        def location
          base_location.join(@project_name)
        end

        def generate_titanium_project
          platform = ::Config::CONFIG['host_os']
          if platform =~ /linux/i || platform =~ /darwin/i
            cmd = "titanium create --name=#{@project_name} --platform=#{@device_platform} --id=#{@app_id}"
            # We need to use the session gem so that we can access the user's aliases
            bash = Session::Bash::new 'program' => 'bash --login -i'
            bash.execute(cmd) { |out, err| puts out }
          else
             error("Currently, your OS (#{::Config::CONFIG['host_os']}) is not supported.")
             exit(0)
          end
        end

      end
    end
  end
end
