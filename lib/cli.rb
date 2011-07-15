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
    desc "generate <model/controller/view> <name> <domain>", "generates a new model, controller, or view with jasmine specs."
    long_desc <<-D
Generate a model, controller, or view. 

Views
  For views, you can specify the "domain", which can be 1 of the following: window, tabgroup, or view.
    D
    def generate(type, name, domain=nil)
      case type
      when /model/i       then Ti::Generator::Model.generate(name)
      when /controller/i  then Ti::Generator::Controller.generate(name)
      when /view/i        then Ti::Generator::View.generate(name, domain)
        
      end
    end
    
    # TODO: compile
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