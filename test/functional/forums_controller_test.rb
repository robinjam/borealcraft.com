require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  setup do
    @category = Category.create!(title: "Test Category")
    @forum = Forum.create!(title: "Test Forum", description: "Test Forum Description")
  end

  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    as_admin { get :new, category_id: @category.to_param }
    assert_response :success
  end

  test "should create forum" do
    assert_difference('Forum.count') do
      as_admin { post :create, forum: Factory.attributes_for(:forum), category_id: @category.to_param }
    end

    assert_not_nil assigns(:forum)
    assert_redirected_to forums_path
  end

  test "should get edit" do
    as_admin { get :edit, id: @forum.to_param }
    assert_response :success
  end

  test "should update forum" do
    as_admin { put :update, id: @forum.to_param, post: @forum.attributes }
    assert_not_nil assigns(:forum)
    assert_redirected_to forums_path
  end

  test "should get delete" do
    as_admin { get :delete, id: @forum.to_param }
    assert_response :success
  end

  test "should destroy forum" do
    assert_difference('Forum.count', -1) do
      as_admin { delete :destroy, id: @forum.to_param }
    end

    assert_redirected_to forums_path
  end
end
