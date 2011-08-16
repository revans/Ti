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
          if execute_titanium
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
          
          # Create the generic templates
          default_templates = ['Rakefile', 'Readme.md', 'Coffeefile']
          default_templates.each do |temp|
            create_file_with_template(temp, temp, @app_properties)
          end
          
          # Last, create some specific iphone files
          if @platform.is_iphone?
            create_entitlements
            symlink_files
          end
        end
        

        # Create directories for the project
        def create_project_directories
          remove_directories('Resources')
          create_directories('Resources/images', 'Resources/vendor', 
            'docs', 
            "app/#{@name_underscore}/models", 
            "app/#{@name_underscore}/helpers",
            "app/#{@name_underscore}/views", 
            "app/#{@name_underscore}/stylesheets/partials",
            'vendor',
            'spec/models', 'spec/views', 'spec/helpers'
          )
        end
        
        
        def self.create_entitlements
          entitlements = project_path.join('build/iphone/Entitlements.plist')
          unless File.exists?(entitlements)
            File.open(entitlements, 'w') do |f|
              f.puts <<-LINE
<?xml versio="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>get-task-allow</key>
  <false/>
</dict>
</plist>
              LINE
            end
          end
        end


        def self.symlink_files
          system("ln -s #{project_path.join('Rakefile')} #{project_path.join('build/iphone/')}")
          system "ln -s #{project_path.join('tiapp.xml')} #{project_path.join('build/iphone/')}"
        end

        
        private
          
          # Execute the creation of a titanium project
          def execute_titanium
            system("#{Ti::Source.compiler_path} create --name=#{@name} --platform=#{@platform} --id=#{@app_id}")
          end
          
          
          # See if the OS is supported. Windows, right now, you're SOL! I hold grudges IE!
          def check_if_system_supported
            if Ti::Source.compiler_path.nil?
              error("Your OS is not supported.")
              exit(0)
            end
          end
        
      end
    end
  end
end