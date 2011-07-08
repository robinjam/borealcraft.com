require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = { title: "Test", content: "This is a test" }
  end

  test "validates with valid attributes" do
    assert Post.new(@valid_attributes).valid?
  end
  
  test "invalid without title" do
    attrs = @valid_attributes.except(:title)
    assert !Post.new(attrs).valid?
    assert !Post.new(attrs.merge title: '').valid?
  end

  test "invalid without content" do
    attrs = @valid_attributes.except(:content)
    assert !Post.new(attrs).valid?
    assert !Post.new(attrs.merge content: '').valid?
  end

  test "article is not published by default" do
    assert !Post.new(@valid_attributes).published?
  end
end
