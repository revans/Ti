module Ti
  module Generator
    class View < Base
      class << self
        attr_accessor :view_type, :path, :context
        
        def generate(path, view_type=nil)
          # Make sure we have a valid view type before we begin
          check_supported_view_types(view_type)
          
          # Setup our path
          @path     = Pathname.new(path)
          @context  = {:name => Ti::Source.config_options[:name], :view_name => @path.basename.downcase,
            :domain => @view_type}
          
          # The view directory to create in the project
          view_directory = "app/#{Ti::Source.config_options[:underscore_name]}/views"
          
          # create the directories for the project
          new_view_path = Pathname.new("#{view_directory}/#{@path.dirname}")
          create_directories("spec/views", new_view_path)
                    
          # Create with a template to be the base of the model file
          create_file_with_template("#{view_directory}/#{@path}.coffee", 
              "app/views/#{view_type}.coffee", 
              @context
          )
          
          # Create the spec file and copy the contents to be used as a placeholder
          create_file_copy_content("spec/views/#{@path}_spec.coffee", "specs/app_spec.coffee")
          create_file_copy_content("app/#{Ti::Source.config_options[:underscore_name]}/stylesheets/_#{@path.basename.downcase}", 
            "app/stylesheets/sample.sass"
          )
          
          # TODO: Append to the router
          
          # Inform the User
          log "#{@path} view has been created."
        end
        
        
        def check_supported_view_types(type)
          type ||= 'generic'
          unless %w(window tabgroup view generic).include?(view_type)
            error "That type of view is not supported."
            exit(0)
          end
          @view_type = type
        end
        
      end
    end
  end
end