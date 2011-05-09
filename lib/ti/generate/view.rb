module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils

        def create(name, context={})
          create_view_template(name, context)
        end
        
        # def create(name, context={})
        #   case
        #   when context[:ti_type] =~ /window/i
        #     create_view_template("app/views/#{context[:domain].downcase}/#{name.downcase}.coffee", context)
        #   else
        #     # create_view_file(name)
        #     log "Creating #{name} view"
        #     template = templates("app/views/#{context[:ti_type]}.erb")
        #     
        #     payload_directory = "app/#{underscore(get_app_name)}/views/#{context[:domain]}"
        #     
        #     
        #     FileUtils.mkdir_p("app/#{underscore(get_app_name)}/views/#{context[:domain]}")
        #     create_with_template("app/#{underscore(get_app_name)}/views/#{context[:domain].downcase}/#{name.downcase}.coffee", template, context)
        #   end
        # end


      end
    end
  end
end
