require 'test_helper'

class HeadlineTest < ActiveSupport::TestCase
  test "title and content are required" do
    headline = Headline.new
    assert headline.invalid?
    assert headline.errors[:title].any?
    assert headline.errors[:content].any?
  end
  
  test "only allows mass assignment of title and content" do
    assert_attributes_accessible Headline, [:title, :content]
    assert_attributes_protected Headline, [:created_at, :updated_at]
  end

  test "destroys all associated comments on delete" do
    headline = FactoryGirl.create(:headline)
    comment = FactoryGirl.create(:comment, commentable: headline)
    headline.destroy
    assert_nil Comment.find_by_id(comment.id), "Comment should have been deleted"
  end
end
