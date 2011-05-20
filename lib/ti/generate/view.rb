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
          when 'tabgroup'
            template  = templates("app/views/tabgroup.erb")
          else
            template  = templates("app/views/view.erb")
          end
          
          payload   = Pathname.new("#{view_directory}/#{(context[:domain] || '').downcase}")
          contents  = Erubis::Eruby.new(File.read(template)).result(context) if template
          
          create_directories(payload)         unless File.directory?(payload)
          create_directories("spec/views")    unless File.directory?("spec/views")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
          create_new_file("app/#{uderscore(get_app_name)}/stylesheets/_#{name}.sass", templates("app/stylesheets/sample.sass"))
        end

      end
    end
  end
end
