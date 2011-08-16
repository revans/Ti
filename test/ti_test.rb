require 'test_helper'

class TiTest < Test::Unit::TestCase
  
  def test_version_number
    assert_match /\d\.\d.\d/, ::Ti.version
  end
  
  def test_titanium_version
    assert_match /\d\.\d.\d/, ::Ti::Source.titanium_version
  end
  
  def test_the_version_of_titaniuam
    assert_equal File.basename(Dir["#{::Ti::Source.titanium_base_path}/*"].sort.last), ::Ti::Source.titanium_version
  end

  def test_root_path
    assert_equal Pathname(__FILE__).dirname.expand_path.join('../lib'), ::Ti::Source.root
  end
  
  def test_project_path
    assert_equal Pathname.new(Dir.pwd),  ::Ti::Source.project_path
  end
  
  def test_compiler_path
    assert_equal '/Library/Application\\ Support/Titanium/mobilesdk/osx/1.6.2/titanium.py', ::Ti::Source.compiler_path.to_s
  end
  
  def test_config_options
    config = ::Ti::Source.config_options
    assert_kind_of Hash, ::Ti::Source.config_options
    assert_equal 'com.shwinkers.shwinkers', config[:id]
    assert_equal 'Shwinkers', config[:name]
    assert_equal 'shwinkers', config[:underscore_name]
    assert_equal '1.6.2', config[:version]
    assert_equal 'Shwinkers', config[:publisher]
    assert_equal 'http://www.shwinkers.com', config[:url]
    assert_equal 'Social Drinking Network', config[:description]
    assert_equal 'Shwinkers', config[:copyright]
  end
  
end