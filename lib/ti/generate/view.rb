module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils
        
        def create(name)
          create_view_file(name)
        end

      end
    end
  end
end