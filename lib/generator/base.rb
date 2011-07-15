module Ti
  module Generator
    class Base
      class << self
        

        def create_file_with_template(name, template_location, contents={})
          template  = templates("#{template_location}.erb")
          eruby     = ::Erubis::Eruby.new(File.rew(template))
          File.open(Ti::Source.project_path.join(name.gsub(/^\//, '')), 'w+') { |f| f.write( eruby.result(contents) ) }
        end
        
        
        def create_file_copy_content(name, file)
          log "Creating #{name} file with the contents from #{file}." if file
          File.open(Ti::Source.project_path.join(file), 'w+') { |f| f.write(File.read(file)) } if file
        end
        
        
        def create_files(*filenames)
          filenames.each do |file|
            next if File.file?(Ti::Source.project_path.join(file))
            log "Creating #{file}."
            FileUtils.touch(Ti::Source.project_path.join(file))
          end
        end
        
        
        def remove_files(*filenames)
          filenames.each do |file|
            log "Deleting #{file}."
            FileUtils.rm(Ti::Source.project_path.join(file))
          end
        end
        
        
        def create_directories(*paths)
          paths.each do |path|
            log "Creating #{path} directory."
            FileUtils.mkdir_p(Ti::Source.project_path.join(path)) unless File.directory?(Ti::Source.project_path.join(path))
          end
        end
        
        
        def remove_directories(*paths)
          paths.each do |path|
            log "Deleting #{path} directory."
            FileUtils.rm_rf(Ti::Source.project_path.join(path))
          end
        end
        
        
        def templates(path)
          ::Ti::Source.root.join('ti/generator/templates').join(path)
        end
        
        
        def log(msg)
          $stdout.puts(msg.green.bold)
        end
        
        
        def error(msg)
          $stderr.puts(msg.red.bold)
        end
        
      end
    end
  end
end