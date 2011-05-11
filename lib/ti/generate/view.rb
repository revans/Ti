module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils

        def create(name, context={})
          create_view_template(name, context)
        end
        

        def create_view_template(name, context)
          log "Creating #{name} view using a template."      
          view_directory = "app/#{underscore(get_app_name)}/views"

          case context[:ti_type]
          when  'window'
            template  = templates("app/views/window.erb")
            payload   = Pathname.new("#{view_directory}/#{context[:domain].downcase}")
          when 'tabgroup'
            template  = templates("app/views/tabgroup.erb")
            payload   = Pathname.new("#{view_directory}/#{context[:domain].downcase}")
          else
            template  = templates("app/views/view.erb")
            payload   = Pathname.new("#{view_directory}/#{context[:domain]}")
          end
          
          contents  = Erubis::Eruby.new(File.read(template)).result if template
          
          create_directories(payload)         unless File.directory?(payload)
          create_directories("spec/views")    unless File.directory?("spec/views")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
        end

      end
    end
  end
end
