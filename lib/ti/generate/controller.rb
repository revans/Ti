module Ti
  module Generate
    class Controller
      class << self
        include Utils

        def create(name, context={})
          create_controller_file(name, context)
        end
        
        
        def create_controller_file(name, context)
          log "Creating #{name} controller using a template."      
          controller_directory = "app/#{underscore(get_app_name)}/controllers"

          case context[:ti_type]
          when 'window'
            template  = templates("app/controllers/window.erb")
            payload   = Pathname.new("#{controller_directory}/#{context[:domain].downcase}")
          else
            template  = templates("app/controllers/controller.erb")
            payload   = Pathname.new("#{controller_directory}/#{context[:domain]}")
          end
          
          contents  = Erubis::Eruby.new(File.read(template)).result if template
          create_directories(payload)             unless File.directory?(payload)
          create_directories("spec/controllers")  unless File.directory?("spec/controllers")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("spec/controllers/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
        end
        

      end
    end
  end
end
