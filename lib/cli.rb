module Ti
  class CLI < Thor
    
    map %w(--version -v) => 'info'
    desc 'info', 'Ti Version'
    def info
      say "Version #{Ti::Source.version}"
    end
    
    map %w(n) => 'new'
    desc "new <name> <app_id> <platform>", "generates an new Ti project."
    long_desc <<-DESC
Generates a new Ti project. See 'ti help new' for more information. iPhone is the default
platform used.
  Examples:
    ti new demo
    ti new demo com.mycompany.app_name
    ti new demo com.mycompany.app_name iphone
    DESC
    def new(name, app_id='com.mycompany.app_name', platform='iphone')
      Ti::Generator::Project.generate(name, app_id, platform)
    end
    
    
    map %w(g) => 'generate'
    desc "generate <model/view> <name> <domain>", "generates a new model or view with jasmine specs."
    long_desc <<-D
Generate a model or view. 

Views
  For views, you can specify the "domain", which can be 1 of the following: window, tabgroup, or view.
    D
    def generate(type, name, domain=nil)
      case type
      when /model/i   then Ti::Generator::Model.generate(name)
      when /view/i    then Ti::Generator::View.generate(name, domain)
      # TODO: Presenter
      end
    end
    
    
    # Compile
    desc "compile <all/coffee/sass>", "compile your coffee-script, sass, or all."
    def compile(type)
      case type.to_s
      when /all/i
        ::Ti::Compile.coffee_script!
        ::Ti::Compile.sass!
      when /coffee/i
        ::Ti::Compile.coffee_script!
      when /sass/i
        ::Ti::Compile.sass!
      end
    end
    
    
    
    # TODO: build
    
    
    
    
    
    STATUS_TYPES = {:success          => 0,
                    :general_error    => 1,
                    :not_supported    => 3,
                    :not_found        => 4,
                    :incorrect_usage  => 64,
                    }

    no_tasks {
    def cli_error(message, exit_status=nil)
      $stderr.puts message
      exit_status = STATUS_TYPES[exit_status] if exit_status.is_a?(Symbol)
      exit(exit_status || 1)
    end
    }
  end
end