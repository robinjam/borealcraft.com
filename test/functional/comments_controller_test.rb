require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should redirect to parent when index action is called" do
    headline = FactoryGirl.create(:headline)
    as_admin { get :index, { headline_id: headline.to_param } }
    assert_redirected_to headline_path(headline)
  end
  
  test "should create comment" do
    assert_difference('Comment.count') do
      as_admin { post :create, { headline_id: FactoryGirl.create(:headline).to_param, comment: { content: "Test comment" } } }
    end

    assert_not_nil assigns(:comment)
    assert_redirected_to headline_path(assigns(:commentable))
  end
end
