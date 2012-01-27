require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "content is required" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors[:content].any?
  end
  
  test "length of comment must be less than 10000 characters" do
    assert Comment.new(content: "a" * 10000).valid?
    assert !Comment.new(content: "a" * 10001).valid?
  end
  
  test "only mass assignment of content is allowed" do
    assert_attributes_accessible Comment, [:content]
    assert_attributes_protected Comment, [:commentable_type, :commentable_id, :user_id, :created_at, :updated_at]
  end
end
