module Utils
  def create_new_file(name, contents)
    log "Creating #{name}"
    File.open(location.join(name), 'w') { |f| f.write(contents) }
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

  def remove_files(*files)
    files.each do |file|
      log "Removing #{file} file."
      FileUtils.rm(location.join(file))
    end
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
  
end