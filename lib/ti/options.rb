module Ti
  class Options

    def self.parse(args)
      options = OpenStruct.new

      ParseOptions.new(args) do |opts|

        opts.value('new') do |name|
          options.name = name
        end
        
        opts.value('-i', '--id') do |id|
          options.device_id = id
        end
        
        opts.value('-p', '--platform') do |platform|
          options.platform = platform
        end
        
        opts.value('generate') do |generate|
          options.generate = !!generate
        end
        
        opts.value('g') do |g|
          options.generate = !!g
        end
        
        opts.value('model') do |model|
          options.model = model
        end
        
        opts.value('view') do |view|
          options.view = view
        end

        opts.help('help', '-h') do
          puts "

Usage: ti new name

Ti Options:

new:        The name of the ti project. 
              e.g. ti new cool_iphone_app
generate    Generate a specific file type:
              e.g. ti generate model user
g           Shortcut for generate
help        View the Help Screen
version     View the current version of Ti

          "
          exit(0)
        end

        opts.version('-v', 'version') do
          puts "Ti's current version is #{Ti::VERSION}"
          exit(0)
        end
      end
      options
    end
  end
end