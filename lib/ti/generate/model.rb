module Ti
  module Generate
    class Model
      class << self
        include Utils
        
        def create(name, options={})
          create_new_file("app/models/#{name}.coffee")
          create_new_file("specs/models/#{name}_spec.coffee", File.read(::Ti::ROOT_PATH.join("ti/templates/specs/app_spec.coffee")))
        end
        
        def location
          base_location
        end
        
      end
    end
  end
end