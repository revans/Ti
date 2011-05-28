require 'coffee_script'
module Ti
  module Compiler
    class CoffeeScripts
      class << self
        include ::Ti::Utils
        
        def compile_all!
          coffeefile  = File.read(base_location.join('Coffeefile')).split("\n").compact.delete_if { |l| l.include?("#") }
          files       = coffeefile.collect { |a| Dir.glob(coffeefile) }.flatten!
          if files.nil?
            log "There are no files to compile."
            exit(0)
          end

          compile_main

          @contents   = ''
          files.uniq!.each { |f| @contents << File.read(f) }
          compile_location = "Resources/#{underscore(get_app_name).downcase}.js"
          compile(@contents, base_location.join(compile_location), :no_wrap => true)
          log "Your CoffeeScripts have been compiled to: #{compile_location}"
        end

        def compile_main
          compile_location = "Resources/app.js"
          @contents = File.read("app/app.coffee")
          compile(@contents, compile_location, :bare => true)
          log "Main app.coffee has been compiled to: #{compile_location}"
        end
        
        def compile(contents, compile_to_location, options={})
          coffeescript  = ::CoffeeScript.compile(contents, options)
          File.open(compile_to_location, 'w') { |f| f.write(coffeescript) }
        end
        
      end
    end
  end
end
