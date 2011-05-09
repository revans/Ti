require 'nokogiri'

module Utils

  def create_new_file(name, contents='')
    log "Creating #{name}"
    File.open(location.join(name), 'w') { |f| f.write(contents) }
  end

  def create_with_template(name, template, contents={})
    # log "Creating #{name} using templates"

    # template = ''

    # unless contents[:domain].nil?
    #   template = "#{::Ti::ROOT_PATH}/ti/templates/controllers/#{contents[:ti_type]}.erb"
    # else
    #   template = "#{::Ti::ROOT_PATH}/ti/templates/views/#{contents[:ti_type]}.erb"
    #   FileUtils.mkdir_p("app/#{underscore(get_app_name)}/views/#{contents[:domain]}")
    # end

    eruby = Erubis::Eruby.new(File.read(template))

    create_new_file(name, eruby.result(contents))
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

  def get_app_name
    config = File.open("tiapp.xml")
    doc = Nokogiri::XML(config)
    config.close
    doc.xpath('ti:app/name').text
  end

  def base_location
    @location ||= Pathname.new(Dir.pwd)
  end

  def underscore(string)
    string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

end
