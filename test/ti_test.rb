require 'test_helper'

class TiTest < Test::Unit::TestCase
  
  def test_version_number
    assert_match /\d\.\d.\d/, ::Ti::VERSION
    assert_match /\d\.\d.\d/, ::Ti.version
  end
  
  def test_titanium_version
    assert_match /\d\.\d.\d/, ::Ti::Source.titanium_version
  end
  
  def test_setting_a_different_titanium_version
    ::Ti::Source.titanium_version = '1.0.0'
    assert_equal '1.0.0', ::Ti::Source.titanium_version
  end
  
  def test_root_path
    assert_equal Pathname(__FILE__).dirname.expand_path.join('../lib'), ::Ti::Source.root
  end
  
  def test_project_path
    assert_equal Pathname.new(Dir.pwd),  ::Ti::Source.project_path
  end
  
  def test_compiler_path
    assert_equal '/Library/Application\\ Support/Titanium/mobilesdk/osx/1.7.2/titanium.py', ::Ti::Source.compiler_path
    ::Ti::Source.titanium_version = '1.6.2'
    assert_equal '/Library/Application\\ Support/Titanium/mobilesdk/osx/1.6.2/titanium.py', ::Ti::Source.compiler_path
  end
  
  def test_config_options
    assert_kind_of Hash, ::Ti::Source.config_options
    assert_same ::Ti::Source.config_options, 
      {:id                =>"com.shwinkers.shwinkers",
       :name              =>"Shwinkers",
       :underscore_name   =>"shwinkers",
       :version           =>"0.6.2",
       :publisher         =>"Shwinkers",
       :url               =>"http://www.shwinkers.com",
       :description       =>"Social Drinking Network",
       :copyright         =>"Shwinkers"}
  end
  
end