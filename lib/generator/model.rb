module Ti
  module Generator
    class Model < Base
      class << self
        
        def generate(name)
          # The model directory to create in the project
          model_directory = "app/#{Ti::Source.config_options[:underscore_name]}/models"
          
          # create the directories for the project
          create_directories(model_directory, "spec/models")
          
          # Create with a template to be the base of the model file
          create_file_with_template("#{model_directory}/#{name}.coffee", 
              "app/models/model.coffee", 
              {:name => Ti::Source.config_options[:name], :model_name => name}
          )
          
          # Create the spec file and copy the contents to be used as a placeholder
          create_file_copy_content("spec/models/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
          # TODO: Left out the appending to a router. Need look into it more.
          
          # Inform the User
          log "#{name} model has been created."
        end
        
        
      end
    end
  end
end