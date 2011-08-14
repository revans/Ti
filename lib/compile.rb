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

      
      # Compile the entire project and run in the simulator
      def project!(device)
        sh %Q{bash -c "#{::Ti::Source.compiler_path} run #{::Ti::Source.project_path}/ #{::Ti::Source.titanium_version} #{::Ti::Source.config_options[:id]} #{::Ti::Source.config_options[:underscore_name]} #{device}" | perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}
      end
      
    end
  end
end