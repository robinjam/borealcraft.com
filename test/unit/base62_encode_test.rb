require 'test_helper'

class Base62EncodeTest < ActiveSupport::TestCase
  def test_base62_encode
    { 0 => "0", -0 => "0", 1 => "1", 10 => "A", 61 => "z", 62 => "10", -62 => "-10" }.each do |k, v|
      assert_equal v, k.base62_encode
    end
  end
end
