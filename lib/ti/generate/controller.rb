module Ti
  module Generate
    class Controller
      class << self
        include Utils

        def create(name, context={})
          log "Creating #{name} controller"
          template = "#{::Ti::ROOT_PATH}/ti/templates/controllers/#{context[:ti_type]}.erb"
          create_with_template("app/#{underscore(get_app_name)}/views/#{name.downcase}.coffee", template, context)
        end

        def location
          base_location
        end

      end
    end
  end
end
