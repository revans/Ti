module Ti
  module Generate
    class Controller
      class << self
        include ::Ti::Utils

        def create(name, context={})
          create_controller_file(name, context)
        end
        
        
        def create_controller_file(name, context)
          log "Creating #{name} controller using a template."     
          app_name  = get_app_name 
          controller_directory = "app/#{underscore(app_name)}/controllers"
          context.merge!(:app_name => app_name, :name => name)
          

          template  = templates("app/controllers/controller.erb")
          payload   = Pathname.new("#{controller_directory}")
          contents  = Erubis::Eruby.new(File.read(template)).result(context) if template
          
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
