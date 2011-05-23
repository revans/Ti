module Ti
  module Generate
    class Model
      class << self
        include ::Ti::Utils
        
        def create(name)
          create_model_file(name)
        end
        
        def create_model_file(name)
          log "Creating a new model file named #{name}."
          model_directory = "app/#{underscore(get_app_name)}/models"

          create_directories(model_directory) unless File.directory?(model_directory)
          create_directories("spec/models")   unless File.directory?("spec/models")

          create_new_file("#{model_directory}/#{name}.coffee")
          create_new_file("spec/models/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
          append_to_router(name, 'models')
        end
        
      end
    end
  end
end
