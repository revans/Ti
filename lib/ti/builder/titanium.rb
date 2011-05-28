module Ti
  module Builder
    class Titanium
      class << self
        include ::Ti::Utils

        def build(platform)
          log "Building with Titanium... DEVICE_TYPE: #{platform}"
          #system ``
        end
      end
    end
  end
end
