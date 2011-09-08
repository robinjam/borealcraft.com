require 'test_helper'

class HeadlineTest < ActiveSupport::TestCase
  test "title and content are required" do
    headline = Headline.new
    assert headline.invalid?
    assert headline.errors[:title].any?
    assert headline.errors[:content].any?
  end
  
  test "only allows mass assignment of title and content" do
    headline = Headline.new(title: "Title", content: "Content", created_at: Time.now, updated_at: Time.now)
    assert_equal "Title", headline.title
    assert_equal "Content", headline.content
    assert_nil headline.created_at
    assert_nil headline.updated_at
  end
end
