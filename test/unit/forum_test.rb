require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  test "title and description are required" do
    forum = Forum.new
    assert forum.invalid?
    assert forum.errors[:title].any?
    assert forum.errors[:description].any?
  end
  
  test "only allows mass assignment of title and description" do
    forum = Forum.new(category_id: 1, title: "Title", description: "Description", created_at: Time.now, updated_at: Time.now)
    assert_nil forum.category_id
    assert_equal "Title", forum.title
    assert_equal "Description", forum.description
    assert_nil forum.created_at
    assert_nil forum.updated_at
  end

  test "destroys all associated topics on delete" do
    forum = Factory(:forum)
    topic = Factory(:topic, forum: forum)
    forum.destroy
    assert_nil Topic.find_by_id(topic.id), "Topic should have been deleted"
  end
  
  test "accessing comments through topics" do
    forum = Factory(:forum)
    topic1 = Factory(:topic, forum: forum)
    topic2 = Factory(:topic, forum: forum)
    Factory(:comment, commentable: topic1)
    Factory(:comment, commentable: topic2)
    assert_equal 2, forum.comments.count
  end
end
