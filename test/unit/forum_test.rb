require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  test "title and description are required" do
    forum = Forum.new
    assert forum.invalid?
    assert forum.errors[:title].any?
    assert forum.errors[:description].any?
  end
  
  test "only allows mass assignment of title and description" do
    assert_attributes_accessible Forum, [:title, :description]
    assert_attributes_protected Forum, [:category_id, :created_at, :updated_at]
  end

  test "destroys all associated topics on delete" do
    forum = FactoryGirl.create(:forum)
    topic = FactoryGirl.create(:topic, forum: forum)
    forum.destroy
    assert_nil Topic.find_by_id(topic.id), "Topic should have been deleted"
  end
  
  test "accessing comments through topics" do
    forum = FactoryGirl.create(:forum)
    topic1 = FactoryGirl.create(:topic, forum: forum)
    topic2 = FactoryGirl.create(:topic, forum: forum)
    FactoryGirl.create(:comment, commentable: topic1)
    FactoryGirl.create(:comment, commentable: topic2)
    assert_equal 2, forum.comments.count
  end
end
