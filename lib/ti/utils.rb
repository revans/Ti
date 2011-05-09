module Ti
  module Utils
        
    def create_new_file(name, file=nil)
      log "Creating #{name}"
      contents = file.nil? ? '' : File.read(::Ti::ROOT_PATH.join(file))
      File.open(location.join(name), 'w') { |f| f.write(contents) }
    end
    
    
    # TODO: Need to create a sample model file to read in for both the model and spec
    def create_model_file(name)
      log "Creating a new model and model spec for #{name}."
      create_new_file(app_model_path("#{name}.coffee"))
      create_new_file(app_model_specs_path("#{name}_spec.coffee"), templates("specs/app_spec.coffee"))
    end
    
    # TODO: Need to create a sample view file to read in for both the view and spec
    def create_view_file(name)
      log "Creating a new view and view spec for #{name}."
      create_new_file(app_view_path("#{name}.coffee"))
      create_new_file(app_view_specs_path("#{name}_spec.coffee"), templates("specs/app_spec.coffee"))
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
      Pathname.new('ti/templates').join(path)
    end
    
    def app_model_path(name)
      Pathname.new('app/models').join(name)
    end
    
    def app_model_specs_path(name)
      Pathname.new('spec/models').join(name)
    end
    
    def app_view_path(name)
      Pathname.new('app/views').join(name)
    end
    
    def app_view_specs_path(name)
      Pathname.new('specs/views').join(name)
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

  end
end