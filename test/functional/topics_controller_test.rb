require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @forum = Factory(:forum)
    @topic = Factory(:topic)
  end
  
  test "should get new" do
    as_user { get :new, forum_id: @forum.to_param }
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      as_user { post :create, forum_id: @forum.to_param, topic: Factory.attributes_for(:topic), comment: Factory.attributes_for(:comment) }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic.to_param
    assert_response :success
  end
end
