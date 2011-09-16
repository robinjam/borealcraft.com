require 'test_helper'

class ScreenshotTest < ActiveSupport::TestCase
  test "title is required" do
    screenshot = Screenshot.new
    assert screenshot.invalid?
    assert screenshot.errors[:title].any?
  end

  test "only allows mass assignment of title and description" do
    screenshot = Screenshot.new(title: "Title", description: "Description", created_at: Time.now, updated_at: Time.now)
    assert_equal "Title", screenshot.title
    assert_equal "Description", screenshot.description
    assert_nil screenshot.created_at
    assert_nil screenshot.updated_at
  end
  
  test "destroys all associated comments on delete" do
    screenshot = Factory(:screenshot)
    comment = Factory(:comment, commentable: screenshot)
    screenshot.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end

  # TODO: Paperclip validations need testing
end
