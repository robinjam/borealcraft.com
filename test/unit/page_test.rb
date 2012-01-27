require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "title and content are required" do
    page = Page.new
    assert page.invalid?
    assert page.errors[:title].any?
    assert page.errors[:content].any?
  end
  
  test "only allows mass assignment of title and content" do
    assert_attributes_accessible Page, [:title, :content]
    assert_attributes_protected Page, [:created_at, :updated_at]
  end
end
