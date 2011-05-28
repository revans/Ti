module Ti
  module Builder
    class Titanium
      class << self
        require 'rake'
        include ::Ti::Utils

        # TODO: This should be loaded properly
        load 'config/config.rb'
        include Config

        def build(platform)
          log "Building with Titanium... DEVICE_TYPE: #{platform}"
          sh %Q{bash -c "#{TI_BUILD} run #{PROJECT_ROOT}/ #{IPHONE_SDK_VERSION} #{APP_ID} #{APP_NAME} #{APP_DEVICE}" | perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}
        end
      end
    end
  end
end
