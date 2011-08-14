module Ti
  class Compile
    class << self
      
      def coffee_script!
        # Use CoffeeScript to compile a single file and write it to our Resources dir
        app_coffee = File.read(::Ti::Source.project_path.join('app.coffee'))
        compiled   = CoffeeScript.compile(app_coffee, :bare => true)
        File.open(::Ti::Source.project_path.join('Resources/app.js'), 'w+') { |f| f.puts compiled }
        
        # Run through the Coffeefile and compile
        output = ::Ti::Source.project_path.join("Resources/#{::Ti::Source.config_options[:underscore_name]}.js")
        Coffeefile.compile_to(output, :bare => true)
      end
      
      
      # Compile - Supports Sass and Compass
      # TODO: Should programatically do this instead of using the
      #       command line to run it.
      def sass!
        `cd #{::Ti::Source.project_path} && sass --compass -C -t expanded app/stylesheets/app.sass > Resources/app.jss`
      end
      
    end
  end
end