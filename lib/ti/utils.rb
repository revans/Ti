module Ti
  module Utils
        
    def create_new_file(name, file=nil)
      log "Creating #{name}"
      contents = file.nil? ? '' : File.read(file)
      File.open(location.join(name), 'w') { |f| f.write(contents) }
    end
  
  
    def create_view_template(name, context, contents = '')
      log "Creating #{name} view using a template."      
      view_directory = "app/#{underscore(get_app_name)}/views"
  
      case 
      when context[:ti_type]
        template  = templates("app/views/#{context[:ti_type]}.erb")
        payload   = Pathname.new("#{view_directory}/#{context[:domain].downcase}")
      else
        template  = templates("app/views/view.erb")
        payload   = Pathname.new("#{view_directory}/#{context[:domain]}")
        contents  = Erubis::Eruby.new(File.read(template)).result if template
      end
      
      create_directories(payload) unless File.directory?(payload)
      filename = payload.join("#{name.downcase}.coffee")
      File.open(location.join(filename), 'w') { |f| f.write(contents) }
      
      create_directories("spec/views")  unless File.directory?("spec/views")
      create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
    end

    
    # TODO: needed?
    # def create_model_template(name, contents={})
    #   log "Creating #{name} model using templates"
    #   eruby = Erubis::Eruby.new( File.read(templates("app/models/model_template.erb")) )
    #   File.open(location.join(name), 'w') { |f| f.write(eruby.result(contents)) }
    # end

    
    # TODO: Need to create a sample model file to read in for both the model and spec
    def create_model_file(name)
      log "Creating a new model and model spec for #{name}."
      model_directory = "app/#{underscore(get_app_name)}/models"
      
      create_directories(model_directory) unless File.directory?(model_directory)
      create_directories("spec/models")   unless File.directory?("spec/models")
      
      create_new_file("#{model_directory}/#{name}.coffee")
      create_new_file("spec/models/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
    end
    
    
    # TODO: Need to create a sample view file to read in for both the view and spec
    def create_view_file(name)
      log "Creating a new view and view spec for #{name}."
      view_directory = "app/#{underscore(get_app_name)}/views"
      create_directories(view_directory)   unless File.directory?(view_directory)
      create_directories("spec/views")  unless File.directory?("spec/views")
      create_new_file("#{view_directory}/#{name}.coffee")
      create_new_file("spec/views/#{name}_spec.coffee", templates("specs/app_spec.coffee"))
    end
    
    def get_app_name
      config  = File.open("tiapp.xml")
      doc     = ::Nokogiri::XML(config)
      config.close
      doc.xpath('ti:app/name').text
    end
    
    def remove_files(*files)
      files.each do |file|
        log "Removing #{file} file."
        FileUtils.rm(location.join(file))
      end
    end
    
  
    def touch(*filenames)
      filenames.each do |filename|
        log "Creating #{filename} file."
        FileUtils.touch(location.join(filename))
      end
    end
    
  
    def create_directories(*dirs)
      dirs.each do |dir|
        log "Creating the #{dir} directory."
        FileUtils.mkdir_p(location.join(dir))
      end
    end
  
    
    def remove_directories(*names)
      names.each do |name|
        log "Removing #{name} directory."
        FileUtils.rm_rf(location.join(name))
      end
    end
    
    
    def templates(path)
      ::Ti::ROOT_PATH.join('ti/templates').join(path)
    end
    
    
    def log(msg)
      ::Ti::Logger.report(msg)
    end
    
    def error(msg)
      ::Ti::Logger.error(msg)
    end
    
    def base_location
      @location ||= Pathname.new(Dir.pwd)
    end
    alias_method :location, :base_location
    
    
    def underscore(string)
      string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
    
  end
end
