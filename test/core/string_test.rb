require 'test_helper'

class StringTest < Test::Unit::TestCase
  
  def test_underscore
    assert_equal "test_this",  "Test this".underscore
  end
  
  def test_iphone
    assert "iphone".is_iphone?
    assert "iPhone".is_iphone?
  end
  
  def test_should_be_false_for_iphone
    assert_equal false, "android".is_iphone?
  end
  
  def test_is_android
    assert "android".is_android?
    assert "Android".is_android?
  end
  
  def test_should_be_false_for_is_android
    assert_equal false, "iphone".is_android?
  end
end