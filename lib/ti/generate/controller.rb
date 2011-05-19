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

          # TODO: I don't think this is needed
          # case context[:ti_type]
          # when 'window'
          #   template  = templates("app/controllers/window.erb")
          # else
          #   template  = templates("app/controllers/controller.erb")
          # end

          template  = templates("app/controllers/controller.erb")

          payload   = Pathname.new("#{controller_directory}")
          contents  = Erubis::Eruby.new(File.read(template)).result(context) if template
          create_directories(payload)             unless File.directory?(payload)
          create_directories("spec/controllers")  unless File.directory?("spec/controllers")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("spec/controllers/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
          create_new_file("app/stylesheets/_#{name}.sass", templates("stylesheets/sample.sass"))
        end
        

      end
    end
  end
end
