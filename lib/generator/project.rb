module Ti
  module Generator
    class Project < Base
      class << self
        
        attr_accessor :name, :app_id, :platform, :app_properties, :name_underscore
        def generate(name, app_id, platform = 'iphone')
          check_if_system_supported
          
          # Assign project properties
          @name, @app_id, @platform, @app_properties = name, app_id, platform, {:name => name, :platform => platform}
          @name_underscore = @name.underscore
          
          # If titanium can create the initial project, then 
          # clean up its mess and give it structure.
          if excute_titanium
            create_project_directories
            create_project_files
            log "#{@name} project has been generated."
          end
        end
        
        
        def create_project_files
          remove_files('README') 
          
          # Create new files using templates
          create_file_with_template('app/app.coffee', 'app/app.coffee', @app_properties)
          create_file_with_template("app/#{@name_underscore}/app.coffee", 'app/app_project.coffee', @app_properties)
          create_file_with_template("app/#{@name_underscore}/api.coffee", 'app/api.coffee',         @app_properties)
          create_file_with_template("app/#{@name_underscore}/helpers/application.coffee", 'app/helpers/application.coffee', @app_properties)
          
          # Create new files by copying their content
          create_file_copy_content('.gitignore', 'gitignore')
          create_file_copy_content("app/#{@name_underscore}/stylesheets/app.sass", 'app/stylesheets/app.sass')
          
          # Lastly, our generic templates
          default_templates = ['Rakefile', 'Readme.md', 'Coffeefile']
          default_templates.each do |temp|
            create_file_copy_content(temp, temp, @app_properties)
          end
        end
        

        # Create directories for the project
        def create_project_directories
          remove_directories('Resources')
          create_directories('Resources/images', 'Resources/vendor', 
            'docs', 
            "app/#{@name.underscore}/models", 
            "app/#{@name.underscore}/helpers",
            "app/#{@name.underscore}/views", 
            "app/#{@name.underscore}/stylesheets/partials",
            'spec/models', 'spec/views', 'spec/helpers')
        end
        

        
        private
          
          # Execute the creation of a titanium project
          def execute_titanium
            system("#{TI::Source.compiler_path} create --name=#{@name} --platform=#{@platform} --id=#{@app_id}")
          end
          
          
          # See if the OS is supported. Windows, right now, you're SOL! I hold grudges IE!
          def check_if_system_supported
            if TI::Source.compiler_path.nil?
              error("Your OS is not supported.")
              exit(0)
            end
          end
        
      end
    end
  end
end