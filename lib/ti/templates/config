require 'nokogiri'

module Config
  config  = File.open('tiapp.xml')
  doc     = Nokogiri::XML(config)
  config.close

  PROJECT_NAME        = "Application Name"
  PROJECT_ROOT        = File.dirname(__FILE__)
  PROJECT_VERSION     = "0.0.1"

  IPHONE_SDK_VERSION  = "4.3"
  ANDROID_SDK_VERSION = ""

  TI_SDK_VERSION      = "1.6.0"
  TI_DIR              = "/Library/Application\ Support/Titanium"

  TI_ASSETS_DIR       = "#{TI_DIR}/mobilesdk/osx/#{TI_SDK_VERSION}"
  TI_IPHONE_DIR       = "#{TI_ASSETS_DIR}/iphone"
  TI_ANDROID_DIR      = "#{TI_ASSETS_DIR}/android"
  TI_BUILD            = "#{TI_IPHONE_DIR}/builder.py"

  # Application
  APP_ID              = doc.xpath('ti:app/id').text
  APP_NAME            = doc.xpath('ti:app/id').text
  APP_DEVICE          = "iphone"
end
