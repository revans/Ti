module Ti
  module Generate
    class View
      class << self
        include ::Ti::Utils


        def create(name, context={})
          case
          when context[:ti_type] =~ /window/i
            create_view_template("app/views/#{context[:domain].downcase}/#{name.downcase}.coffee", context)
          else
            create_view_file(name)
          end
        end


      end
    end
  end
end
