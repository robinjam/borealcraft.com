require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "title is required" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:title].any?
  end
  
  test "only allows mass assignment of title" do
    category = Category.new(title: "Title", created_at: Time.now, updated_at: Time.now)
    assert_equal "Title", category.title
    assert_nil category.created_at
    assert_nil category.updated_at
  end

  test "destroys all associated forums on delete" do
    category = Factory(:category)
    forum = Factory(:forum, category: category)
    category.destroy
    assert_nil Forum.find_by_id(forum.id), "Forum should have been deleted"
  end
end
