module Ti
  module Generate
    class Model
      class << self
        include ::Ti::Utils
        
        def create(name)
          create_model_file(name)
        end
        
      end
    end
  end
end
