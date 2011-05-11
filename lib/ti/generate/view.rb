module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils

        def create(name, context={})
          create_view_template(name, context)
        end
        
        # def create_view_file(name)
        #   log "Creating a new view and view spec for #{name}."
        #   view_directory = "app/#{underscore(get_app_name)}/views"
        #   create_directories(view_directory)    unless File.directory?(view_directory)
        #   create_directories("spec/views")      unless File.directory?("spec/views")
        #   create_new_file("#{view_directory}/#{name}.coffee")
        #   create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
        # end
        
        def create_view_template(name, context)
          log "Creating #{name} view using a template."      
          view_directory = "app/#{underscore(get_app_name)}/views"

          case 
          when context[:ti_type]
            template  = templates("app/views/#{context[:ti_type]}.erb")
            payload   = Pathname.new("#{view_directory}/#{context[:domain].downcase}")
          else
            template  = templates("app/views/view.erb")
            payload   = Pathname.new("#{view_directory}/#{context[:domain]}")
            contents  = Erubis::Eruby.new(File.read(template)).result if template
          end

          create_directories(payload)         unless File.directory?(payload)
          create_directories("specs/views")   unless File.directory?("spec/views")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("specs/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
        end

      end
    end
  end
end
