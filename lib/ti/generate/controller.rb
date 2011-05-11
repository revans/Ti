module Ti
  module Generate
    class Controller
      class << self
        include Utils

        def create(name, context={})
          # log "Creating #{name} controller"
          # template = "#{::Ti::ROOT_PATH}/ti/templates/controllers/#{context[:ti_type]}.erb"
          # create_with_template("app/#{underscore(get_app_name)}/views/#{name.downcase}.coffee", template, context)
          create_controller_file(name, context)
        end
        
        
        def create_controller_file(name, context)
          log "Creating #{name} controller using a template."      
          controller_directory = "app/#{underscore(get_app_name)}/controllers"

          case 
          when context[:ti_type]
            template  = templates("app/controllers/#{context[:ti_type]}.erb")
            payload   = Pathname.new("#{controller_directory}/#{context[:domain].downcase}")
          else
            template  = templates("app/controllers/controller.erb")
            payload   = Pathname.new("#{controller_directory}/#{context[:domain]}")
            contents  = Erubis::Eruby.new(File.read(template)).result if template
          end

          create_directories(payload)             unless File.directory?(payload)
          create_directories("specs/controllers") unless File.directory?("spec/views")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("specs/controllers/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
        end
        

      end
    end
  end
end
