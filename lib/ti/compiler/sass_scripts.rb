require 'sass'
module Ti
  module Compiler
    class SASSScripts
      class << self
        include ::Ti::Utils

        # def compile(contents, compile_to_location)
        def compile
          system "sass --compass -C -t expand app/#{underscore(get_app_name)}/stylesheets/app.sass > Resources/app.jss"
          log "Your SASS have been compiled to: Resources/app.jss"
        end
      end
    end
  end
end
