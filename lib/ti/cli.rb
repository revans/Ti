module Ti
  class CLI < Thor
    
    STATUS_TYPES = {:success          => 0,
                    :general_error    => 1,
                    :not_supported    => 3,
                    :not_found        => 4,
                    :incorrect_usage  => 64,
                    }
    
    map %w(--version -v) => 'info'
    desc "info", "information about Ti."
    def info
      say "Version #{::Ti::VERSION}"
    end
    
    desc "ti new <name> <id> <platform>", "generates a new Titanium project."
    def new(name, device_id='org.mycompany.demo', platform='iphone')
      ::Ti::Generate::Project.create(name, device_id, platform)
    end
    
  end
end