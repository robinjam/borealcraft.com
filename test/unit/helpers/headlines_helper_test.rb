require 'test_helper'

class HeadlinesHelperTest < ActionView::TestCase
  test "published_date_of" do
    headline = headlines(:one)
    headline.created_at = 1.hour.ago
    assert_equal "about 1 hour ago", published_date_of(headline)
    headline.created_at = 2.hours.ago
    assert_equal "about 2 hours ago", published_date_of(headline)
    headline.created_at = Date.new(1991, 04, 30).to_time + 12.hours
    assert_equal "30th April 1991", published_date_of(headline)
  end
end
