require 'test_helper'

class StringTest < Test::Unit::TestCase
  
  def test_underscore
    assert_equal "test_this",  "Test this".underscore
  end
  
end