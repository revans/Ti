module Ti
  module Generate
    class View
      class << self
        include Utils
        
        def create(name, context={})
          case
          when context[:ti_type] =~ /window/i
            create_with_template("app/#{underscore(get_app_name)}/views/#{context[:domain].downcase}/#{name.downcase}.coffee", context)
          end
          # create_new_file("app/views/#{name}.coffee")
          # create_new_file("specs/views/#{name}_spec.coffee", File.read(::Ti::ROOT_PATH.join("ti/templates/specs/app_spec.coffee")))
        end

        def location
          base_location
        end
        
      end
    end
  end
end
