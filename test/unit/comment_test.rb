require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "content is required" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors[:content].any?
  end
  
  test "length of comment must be between 15 and 1000 characters" do
    assert Comment.new(content: "a" * 15).valid?
    assert !Comment.new(content: "a" * 14).valid?
    assert Comment.new(content: "a" * 1000).valid?
    assert !Comment.new(content: "a" * 1001).valid?
  end
  
  test "only mass assignment of content is allowed" do
    comment = Comment.new(commentable_type: "commentable_type", commentable_id: 1, user_id: 1, content: "content", created_at: Time.now, updated_at: Time.now)
    assert_nil comment.commentable_type
    assert_nil comment.commentable_id
    assert_nil comment.user_id
    assert_equal "content", comment.content
    assert_nil comment.created_at
    assert_nil comment.updated_at
  end
end
