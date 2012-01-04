require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "title is required" do
    topic = Topic.new
    assert topic.invalid?
    assert topic.errors[:title].any?
  end
  
  test "only allows mass assignment of title" do
    topic = Topic.new(forum_id: 1, title: "Title", locked: true, sticky: true, created_at: Time.now, updated_at: Time.now)
    assert_nil topic.forum_id
    assert_equal "Title", topic.title
    assert_nil topic.locked
    assert_nil topic.sticky
    assert_nil topic.created_at
    assert_nil topic.updated_at
  end

  test "destroys all associated comments on delete" do
    topic = Factory(:topic)
    comment = Factory(:comment, commentable: topic)
    topic.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end
end
