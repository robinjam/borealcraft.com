require 'test_helper'

class ScreenshotsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:screenshots)
  end

  test "should get new" do
    as_user { get :new }
    assert_response :success
  end

  test "should create screenshot" do
    assert_difference('Screenshot.count') do
      as_user { post :create, screenshot: Factory.attributes_for(:screenshot) }
    end

    assert_not_nil assigns(:screenshot)
    assert_redirected_to screenshot_path(assigns(:screenshot))
  end

  test "should get edit" do
    as_admin { get :edit, id: Factory(:screenshot).to_param }
    assert_response :success
    assert_not_nil assigns(:screenshot)
  end

  test "should update screenshot" do
    screenshot = Factory(:screenshot)
    as_admin { post :update, id: screenshot.to_param, screenshot: screenshot.attributes.slice(:description).merge(title: 'Updated title') }
    assert_redirected_to screenshot_path(assigns(:screenshot))
    assert_equal 'Updated title', assigns(:screenshot).title
  end

  test "should get delete" do
    as_admin { get :delete, id: Factory(:screenshot).to_param }
    assert_response :success
  end

  test "should destroy screenshot" do
    screenshot = Factory(:screenshot)
    assert_difference('Screenshot.count', -1) do
      as_admin { delete :destroy, id: screenshot.to_param }
    end

    assert_redirected_to screenshots_path
  end
end
