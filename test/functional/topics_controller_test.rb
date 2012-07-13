require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @category = FactoryGirl.create(:category)
    @forum = FactoryGirl.create(:forum, category: @category)
    @topic = FactoryGirl.create(:topic, forum: @forum)
  end
  
  test "should get new" do
    as_user { get :new, forum_id: @forum.to_param }
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      as_user { post :create, forum_id: @forum.to_param, topic: FactoryGirl.attributes_for(:topic), comment: FactoryGirl.attributes_for(:comment) }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic.to_param
    assert_response :success
  end
end
