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
		  
		  if platform == "android"
			sdk = ANDROID_SDK_VERSION
			builder = "#{TI_ANDROID_DIR}/builder.py"
		  elsif platform == "iphone" || platform == "ipad"
			sdk = IPHONE_SDK_VERSION
			builder = "#{TI_IPHONE_DIR}/builder.py"
		  end
		  
		  builder = "#{TI_ASSETS_DIR}/#{platform}/builder.py"
          sh %Q{bash -c "#{builder} run #{PROJECT_ROOT}/ #{sdk} #{APP_ID} #{APP_NAME} #{APP_DEVICE}" | perl -pe 's/^\\[DEBUG\\].*$/\\e[35m$&\\e[0m/g;s/^\\[INFO\\].*$/\\e[36m$&\\e[0m/g;s/^\\[WARN\\].*$/\\e[33m$&\\e[0m/g;s/^\\[ERROR\\].*$/\\e[31m$&\\e[0m/g;'}
        end
      end
    end
  end
end
