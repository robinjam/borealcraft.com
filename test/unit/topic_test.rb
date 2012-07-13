require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "title is required" do
    topic = Topic.new
    assert topic.invalid?
    assert topic.errors[:title].any?
  end
  
  test "only allows mass assignment of title" do
    assert_attributes_accessible Topic, [:title]
    assert_attributes_protected Topic, [:forum_id, :locked, :sticky, :created_at, :updated_at]
  end

  test "destroys all associated comments on delete" do
    topic = FactoryGirl.create(:topic)
    comment = FactoryGirl.create(:comment, commentable: topic)
    topic.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end
end
