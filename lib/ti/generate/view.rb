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
          app_name  = get_app_name 
          view_directory = "app/#{underscore(app_name)}/views"
          context.merge!(:app_name => app_name, :name => name)
          
          case context[:ti_type]
          when  'window'
            template  = templates("app/views/window.erb")
          when 'tabgroup'
            template  = templates("app/views/tabgroup.erb")
          when 'view'
            template  = templates("app/views/view.erb")
          else
            template  = templates("app/views/generic.erb")
          end
          
          payload   = Pathname.new("#{view_directory}/#{(context[:domain] || '').downcase}")
          contents  = Erubis::Eruby.new(File.read(template)).result(context) if template
          
          create_directories(payload)         unless File.directory?(payload)
          create_directories("spec/views")    unless File.directory?("spec/views")
          
          filename = payload.join("#{name.downcase}.coffee")
          File.open(location.join(filename), 'w') { |f| f.write(contents) }

          create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
          create_new_file("app/#{underscore(app_name)}/stylesheets/_#{context[:domain].downcase}.sass", templates("app/stylesheets/sample.sass"))
        end

      end
    end
  end
end
