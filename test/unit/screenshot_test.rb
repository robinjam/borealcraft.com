require 'test_helper'

class ScreenshotTest < ActiveSupport::TestCase
  test "title is required" do
    screenshot = Screenshot.new
    assert screenshot.invalid?
    assert screenshot.errors[:title].any?
  end

  test "only allows mass assignment of title and description" do
    assert_attributes_accessible Screenshot, [:title, :description]
    assert_attributes_protected Screenshot, [:user_id, :created_at, :updated_at]
  end
  
  test "destroys all associated comments on delete" do
    screenshot = Factory(:screenshot)
    comment = Factory(:comment, commentable: screenshot)
    screenshot.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end

  # TODO: Paperclip validations need testing
end
