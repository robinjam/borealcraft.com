require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "title and content are required" do
    page = Page.new
    assert page.invalid?
    assert page.errors[:title].any?
    assert page.errors[:content].any?
  end
  
  test "only allows mass assignment of title and content" do
    page = Page.new(title: "Title", content: "Content", created_at: Time.now, updated_at: Time.now)
    assert_equal "Title", page.title
    assert_equal "Content", page.content
    assert_nil page.created_at
    assert_nil page.updated_at
  end
end
