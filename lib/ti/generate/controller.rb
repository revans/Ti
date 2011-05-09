module Ti
  module Generate
    class Controller
      class << self
        include Utils

        def create(name, context={})
          create_with_template("app/#{underscore(get_app_name)}/views/#{name}.coffee", context)
        end

        def location
          base_location
        end

      end
    end
  end
end
