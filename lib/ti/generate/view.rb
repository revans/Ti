module Ti
  module Generate
    class View
      class << self
        include Utils
        
        def create(name, context={})
          case
          when context[:ti_type] =~ /window/i
            log "Creating #{name} view"
            template = "#{::Ti::ROOT_PATH}/ti/templates/views/#{context[:ti_type]}.erb"
            FileUtils.mkdir_p("app/#{underscore(get_app_name)}/views/#{context[:domain]}")
            create_with_template("app/#{underscore(get_app_name)}/views/#{context[:domain].downcase}/#{name.downcase}.coffee", template, context)
          end
        end

        def location
          base_location
        end
        
      end
    end
  end
end
