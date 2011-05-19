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
          eruby = Erubis::Eruby.new( File.read(templates("defaults/config.erb")) )
          File.open(location.join("config/config.rb"), 'w') do |f| 
            f.write(eruby.result(:project_name => project_name)) 
          end
        end
        
        def create_defaults_with_template(name, contents={})
          template = templates("defaults/#{name}.erb")
          eruby = Erubis::Eruby.new(File.read(template))

          File.open(location.join(name), 'w') do |f| 
            f.write(eruby.result(contents))
          end

        end

        def create_rakefile_from_template(project_name)
          eruby = Erubis::Eruby.new( File.read(templates("defaults/Rakefile.erb")) )
          File.open(location.join("Rakefile"), 'w') do |f| 
            f.write( eruby.result({
                :app_name             => project_name, 
                :app_name_underscore  => underscore(project_name)
            })) 
          end
        end

        def generate_files
          create_project_directory
          touch('Readme.mkd')
          # touch('specs/spec_helper.coffee') # TODO: Necessary? If so, what is in it?

          # create_new_file("app/app.coffee",         templates('app/app.coffee'))
          project_template = templates('app/app.coffee.erb')
          project_contents = Erubis::Eruby.new(File.read(project_template)).result(:app_name => @project_name, :app_name_underscore => underscore(@project_name)) if project_template
          File.open(location.join('app/app.coffee'), 'w') { |f| f.write(project_contents) }

          app_project_template = templates('app/app_project.coffee.erb')
          app_project_contents = Erubis::Eruby.new(File.read(app_project_template)).result(:app_name => @project_name) if app_project_template
          File.open(location.join("app/#{underscore(@project_name)}/app.coffee"), 'w') { |f| f.write(app_project_contents)}

          create_new_file(".gitignore",             templates('gitignore'))
          create_new_file("spec/app_spec.coffee",   templates('specs/app_spec.coffee'))
          
          
          # TODO: these can be refactored
          create_config_from_templates(@project_name)
          create_defaults_with_template("Rakefile", {:app_name => @project_name, :app_name_underscore => underscore(@project_name)})
          create_defaults_with_template("Readme.mkd", {:app_name => @project_name})
          create_defaults_with_template("Guardfile", {:app_name => underscore(@project_name)})
          
          
          
          
          # load default images
          FileUtils.cp("/tmp/KS_nav_ui.png",    location.join("Resources/images/"))
          FileUtils.cp("/tmp/KS_nav_views.png", location.join("Resources/images/"))
        end
        
        
        def create_project_directory
          create_directories('Resources', 'Resources/images', 'Resources/vendor', 
            'config', 
            'docs', 
            "app/#{underscore(@project_name)}/models", 
            "app/#{underscore(@project_name)}/views", 
            "app/#{underscore(@project_name)}/stylesheets", 
            'spec/models', 'spec/views') 
        end
        
        def remove_old_files
          remove_files('README')          
          remove_directories('Resources')
        end

        def location
          base_location.join(@project_name)
        end


        def generate_titanium_project
          titanium_platform = case ::Config::CONFIG['host_os']
          when /linux/i
            ::Ti::LINUX_TITANIUM
          when /darwin/i
            File.exists?(::Ti::OSX_TITANIUM.gsub('\\', '')) ? ::Ti::OSX_TITANIUM : ::Ti::OSX_TITANIUM_HOME
          else
            error("Currently, your OS (#{::Config::CONFIG['host_os']}) is not supported.")
            exit(0)
          end
          
          "#{titanium_platform} create --name=#{@project_name} --platform=#{@device_platform} --id=#{@app_id}"
        end

      end
    end
  end
end
