module Ti
  module Generate
    class Project
      class << self
        attr_accessor :project_name, :device_platform, :app_id
        include Utils

        # Ti::Generate::Project.create('demo', 'org.codewranglers.demo', 'ipad')
        def create(name, id, platform='iphone')
          @project_name    = name
          @device_platform = platform
          @app_id          = id
          if system(generate_titanium_project)
            create_directories('tmp')
            copy_defaults
            remove_old_files
            generate_files
            log "Your Titanium project is ready for you to get rockin!"
          else
            error "There was an error generating your Titanium project."
          end
        end


        def copy_defaults
          FileUtils.cp(location.join("Resources/KS_nav_ui.png"),    "/tmp/")
          FileUtils.cp(location.join("Resources/KS_nav_views.png"), "/tmp/")
        end

        def create_config_from_templates(project_name)
          template = "#{::Ti::ROOT_PATH}/ti/templates/defaults/config.erb"
          eruby = Erubis::Eruby.new(File.read(template))
          create_new_file("config/config.rb", eruby.result(:project_name => project_name))
        end

        def create_rakefile_from_template(project_name)
          template = "#{::Ti::ROOT_PATH}/ti/templates/defaults/Rakefile.erb"
          eruby = Erubis::Eruby.new(File.read(template))
          create_new_file("Rakefile", eruby.result({:app_name => project_name, :app_name_underscore => underscore(project_name)}))
        end

        def generate_files
          create_project_directory
          touch('Readme.mkd')
          # touch('specs/spec_helper.coffee') # TODO: Necessary? If so, what is in it?

          create_new_file("app/app.coffee",     File.read(::Ti::ROOT_PATH.join('ti/templates/app/app.coffee')))
          create_new_file(".gitignore",         File.read(::Ti::ROOT_PATH.join('ti/templates/gitignore')))
          # create_new_file("config/config.rb",   File.read(::Ti::ROOT_PATH.join('ti/templates/config')))
          create_config_from_templates(@project_name)
          create_rakefile_from_template(@project_name)
          # create_new_file("Rakefile",           File.read(::Ti::ROOT_PATH.join('ti/templates/rakefile')))
          create_new_file("Readme.mkd",         File.read(::Ti::ROOT_PATH.join('ti/templates/readme')))
          create_new_file("Guardfile",          File.read(::Ti::ROOT_PATH.join('ti/templates/guardfile')))
          create_new_file("specs/app_spec.coffee",          File.read(::Ti::ROOT_PATH.join('ti/templates/specs/app_spec.coffee')))
          
          # load default images
          FileUtils.cp("/tmp/KS_nav_ui.png",    location.join("Resources/images/"))
          FileUtils.cp("/tmp/KS_nav_views.png", location.join("Resources/images/"))
        end
        
        def create_project_directory
          create_directories('Resources', 'Resources/images', 'Resources/vendor', 
            'config', 
            'docs', 
            'app/models', 'app/views', 'app/stylesheets', 
            'specs/models', 'specs/views') 
        end
        
        def remove_old_files
          remove_files('README')          
          remove_directories('Resources')
        end

        def location
          base_location.join(@project_name)
        end

        # TODO: Need to look at what system this is being ran on. If OSX check if titanium was installed in the $HOME dir.
        def generate_titanium_project
          "#{::Ti::OSX_TITANIUM} create --name=#{@project_name} --platform=#{@device_platform} --id=#{@app_id}"
        end

      end
    end
  end
end
