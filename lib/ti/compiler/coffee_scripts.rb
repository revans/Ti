module Ti
  module Compiler
    class CoffeeScripts
      class << self
        include ::Ti::Utils
        
        def compile_all!
          coffeefile  = File.read(base_location.join('Coffeefile')).split('\n').compact.delete_if { |l| l.include?("#") }
          files       = coffeefile.collect { |a| Dir.glob[a] }.flatten!.uniq
          @contents   = ''
          files.each { |f| @contents << File.read(f) }
          compile(@contents, base_location.join("Resources/#{get_app_name}.js")
        end
        
        def compile(contents, compile_to_location)
          coffeescript  = CoffeeScript.compile(contents, :no_wrap => false)
          File.open(compile_to_location, 'w') { |f| f.write(coffeescript) }
        end
        
      end
    end
  end
end