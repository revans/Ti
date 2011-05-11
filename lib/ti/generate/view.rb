module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils

        def create(name, context={})
          create_view_template(name, context)
        end

      end
    end
  end
end
