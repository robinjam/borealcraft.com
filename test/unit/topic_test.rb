require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "topic author is author of first comment" do
    assert_equal users(:notch), topics(:rules).user
    assert_equal users(:jeb_), topics(:one_point_zero).user
  end
end
