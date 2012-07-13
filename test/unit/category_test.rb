require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "title is required" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:title].any?
  end
  
  test "only allows mass assignment of title" do
    assert_attributes_accessible Category, [:title]
    assert_attributes_protected Category, [:created_at, :updated_at]
  end

  test "destroys all associated forums on delete" do
    category = FactoryGirl.create(:category)
    forum = FactoryGirl.create(:forum, category: category)
    category.destroy
    assert_nil Forum.find_by_id(forum.id), "Forum should have been deleted"
  end
end
