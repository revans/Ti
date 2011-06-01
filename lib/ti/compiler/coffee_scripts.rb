require 'coffee_script'
module Ti
  module Compiler
    class CoffeeScripts
      class << self
        include ::Ti::Utils
        
        def compile_all!
          coffeefile  = File.read(base_location.join('Coffeefile')).split("\n").compact.delete_if { |l| l.include?("#") }
          files       = coffeefile.collect { |a| Dir.glob(coffeefile) }.flatten!.uniq
          if files.nil?
            log "There are no files to compile."
            exit(0)
          end
          
          compile_main
          compile_location = "Resources/#{underscore(get_app_name).downcase}.js"
          compile(files.join(' '), base_location.join(compile_location), :bare => true, :join => true)
        end

        def compile_main
          compile("app/app.coffee", base_location.join("Resources/app.js"), :bare => true)
        end
        
        def compile(files, compile_to_location, options={})
          coffee_options  = []
          options.each { |k,v| coffee_options << "--#{k.to_s}" if v} unless options.empty?
          system("coffee -p #{coffee_options.join(' ')} #{files} > #{compile_to_location}")
          log "Your CoffeeScripts have been compiled to: #{compile_to_location}"
        end
        
      end
    end
  end
end
